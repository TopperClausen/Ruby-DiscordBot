class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  def response(body:, status: :ok)
    render json: body, status: status
  end
end
