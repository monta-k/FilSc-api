class ApplicationController < ActionController::API
  private

  def authenticate_firebase_id_token
    token = request.headers['Authorization']
    FirebaseAuth::Auth.verify_id_token(token)
  rescue StandardError => e
    logger.error(e.message)
    false
  end

  def authenticate
    render json: { message: 'some error' }, status: :unprocessable_entity unless @decoded_token = authenticate_firebase_id_token
    render json: { message: 'some error' }, status: :unprocessable_entity unless @current_user = User.find_by(uid: @decoded_token['uid'])
  end

  def current_user
    @current_user ||= User.find_by(uid: @decoded_token['uid'])
  end
end
