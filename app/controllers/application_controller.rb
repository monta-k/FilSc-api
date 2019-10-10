class ApplicationController < ActionController::API
  attr_reader :current_user

  private

  def authenticate_firebase_id_token
    token = request.headers['Authorization']
    decoded_token = FirebaseAuth::Auth.verify_id_token(token).symbolize_keys[:decode_token][:payload].symbolize_keys
    logger.debug
    decoded_token
  rescue StandardError => e
    logger.error(e.message)
    false
  end

  def authenticate
    render json: { message: 'some error' }, status: :unprocessable_entity unless decoded_token = authenticate_firebase_id_token
    render json: { message: 'some error' }, status: :unprocessable_entity unless @current_user = User.find_by(uid: decoded_token[:user_id])
  end
end
