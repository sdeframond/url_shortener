class Api::V1::VisitsController < Api::V1::ApplicationController
  def index
    from = params[:from]
    to = params[:to]
    url_id = params[:shortened_url_id]
    if [from, to].any?(&:nil?)
      error = {error: "You need to provide both parameters :from and :to."}
      respond_with error, status: 400
    else
      url = ShortenedUrl.find_by_url_hash!(url_id)
      respond_with url.visits.where(created_at: from...to)
    end
  end
end