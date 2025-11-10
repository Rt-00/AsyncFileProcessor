class FileProcessingService
  def initialize(upload)
    @upload = upload
  end

  # Identifica tipo por extensão ou content_type e enfileira job
  def call
    @upload.update!(status: "processing")

    filename = @upload.filename
    attached = @upload.file
    raise "File not attached" unless attached.attached?

    # Dou preferência ao content_type sempre que disponível
    ct = @upload.content_type.to_s

    if ct.include?("json") || filename.downcase.end_with?(".json")
      JsonProcessingJob.perform_async(@upload.id)
    elsif ct.include?("csv") || filename.downcase.end_with?(".csv")
      CsvProcessingJob.perform_async(@upload.id)
    else
      # Fallback: tento detectar pelo conteúdo
      blob = attached.download
      trimmed = blob.strip

      if trimmed.start_with?("{", "[")
        JsonProcessingJob.perform_async(@upload.id)
      else
        CsvProcessingJob.perform_async(@upload.id)
      end
    end

  rescue => e
    @upload.update!(status: "failed", error_message: e.message)
    raise
  end
end
