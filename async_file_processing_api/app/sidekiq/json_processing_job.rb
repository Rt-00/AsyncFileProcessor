class JsonProcessingJob
  include Sidekiq::Job

  def perform(upload_id)
    upload = Upload.find(upload_id)
    upload.update!(status: "processing")

    blob = upload.file.download
    payload = JSON.parse(blob)

    created = 0

    # Payload pode ser uma lista ou um objeto com chave 'products'
    items = if payload.is_a?(Array)
      payload
    elsif payload.is_a?(Hash) && payload["products"].is_a?(Array)
      payload["products"]
    else
      [ payload ]
    end

    items.each do |item|
      begin
        attributes = {
          name: item["name"] || item["nome"] || item["title"],
          sku: item["sku"],
          price: parse_decimal(item["price"] || item["preco"]),
          description: item["description"] || item["descricao"],
          stock: (item["stock"] || item["estoque"] || 0).to_i
        }

        next unless attributes[:name].present?

        Product.create!(attributes)
        created += 1
      rescue => e
        Rails.logger.error("JSON item error: #{e.messsage} -- #{item}")
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
