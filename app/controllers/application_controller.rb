class ApplicationController < ActionController::API
  before_action :authorize_request

  def encode_token(payload)
    JWT.encode(payload, Rails.application.secret_key_base)
  end

  def decode_token
    header = request.headers["Authorization"]
    return nil unless header.present?

    token = header.split.last
    begin
      JWT.decode(token, Rails.application.secret_key_base)[0]
    rescue
      nil
    end
  end

  def authorize_request
    decoded = decode_token

    if decoded
      @current_user = User.find_by(id: decoded["user_id"])
    end

    render json: { error: "Not Authorized" }, status: :unauthorized unless @current_user
  end

  def current_user
  @current_user
  end
end
