class Api::V1::ShortenedUrlsController < Api::V1::ApplicationController
  def show
    url = ShortenedUrl.find_by_url_hash!(params[:id])
    respond_to do |format|
      format.json {
        render json: url
      }
    end
  end
end