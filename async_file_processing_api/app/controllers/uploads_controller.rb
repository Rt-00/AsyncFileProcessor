class UploadsController < ApplicationController
  def index
    uploads = Upload.order(created_at: :desc).limit(50)

    render json: uploads.map { |u| {
      id: u.id,
      filename: u.filename,
      status: u.status,
      created_at: u.created_at
      }
    }
  end

  def show
    upload = Upload.find(params[:id])

    render json: {
      id: upload.id,
      filename: upload.filename,
      status: upload.status,
      product_count: upload.product_count,
      error_message: upload.error_message
    }
  end

  def create
    file = params[:file]
    unless file.present?
      return render json: { error: "file is required" }, status: :bad_request
    end

    upload = Upload.create!(
      filename: file.original_filename,
      content_type: file.content_type
    )
    upload.file.attach(file)

    # Enfileira o processamento via service
    FileProcessingService.new(upload).call

    render json: { id: upload.id, status: upload.status }, status: :accepted
  rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.record.erros.full_messages }, status: :unprocessable_content
  end
end
