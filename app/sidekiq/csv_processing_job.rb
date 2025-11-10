require "csv"

class CsvProcessingJob
  include Sidekiq::Job

  def perform(upload_id)
    upload = Upload.find(upload_id)
    upload.update!(status: "processing")

    blob = upload.file.download.force_encoding("UTF-8")

    created = 0
    CSV.parse(blob, headers: true) do |row|
      # mapear colunas do CSV para atributos do Product
      begin
        attributes = {
          name: row["name"] || row["nome"] || row["title"],
          sku: row["sku"],
          price: parse_decimal(row["price"] || row["preco"]),
          description: row["description"] || row["descricao"],
          stock: (row["stock"] || row["estoque"] || 0).to_i
        }

        next unless attributes[:name].present?

        Product.create!(attributes)
        created += 1
      rescue => e
        Rails.logger.error("CSV row error: #{e.message} -- #{row.to_h}")
      end
    end

    upload.update!(status: "done", product_count: created)
  rescue => e
    upload.update!(status: "failed", error_message: e.message)
    raise
  end

  private

  def parse_decimal(value)
    return nil if value.nil?
    value = value.to_s.strip
    value = value.gsub(/[R$\s]/, "")
    value = value.tr(",", ".") if value =~ /,\d{1,2}$/
    BigDecimal(value)
  rescue
    nil
  end
end
