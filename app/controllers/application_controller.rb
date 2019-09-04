class ApplicationController < ActionController::API
  private
  
  def authenticate_firebase_id_token
    token = request.headers['Authorization']
    FirebaseAuth::Auth.verify_id_token(token)
  rescue => e
    logger.error(e.message)
    false
  end

  def authenticate
    return if authenticate_firebase_id_token && (@current_user = User.find_by(uid: decoded_token['uid']))
    render json: { message: 'some error' }, status: :unprocessable_entity
  end
end
