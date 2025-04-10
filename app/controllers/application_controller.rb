class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :set_user_cookie_and_sessioon

  def set_user_cookie_and_sessioon

    if cookies.permanent.signed[:visitor_id]
      unless request.headers['HTTP_SESSION_ID']
        session = create_new_session
        session.user = current_user
        set_current_session(session)
        # Set the session ID in the response header
        session.save
        session_id = session.uuid
        request.set_header('session_id', session_id)
        response.set_header('session_id', session_id) 
      end
      
    else
      user = create_new_user
      session = create_new_session
      # Create a new session and associate it with the user
      session.user = user
      session.save

      # Set the session ID in the response header
      session_id = session.uuid
      response.set_header('session_id', session_id)
      set_current_session(session)
      
      # Set the visitor ID in the cookie
      uuid = user.uuid
      cookies.permanent.signed[:visitor_id] = { value: uuid, httponly: true }
    end

  end

  def create_new_user
    uuid = SecureRandom.uuid
    User.create(uuid: uuid)
  end

  def create_new_session
    uuid = SecureRandom.uuid
    Session.create(uuid: uuid)
  end

  def set_current_session(session)
    @current_session = session
  end

  def current_session 
    @current_session ||= Session.find_by(uuid: request.headers['HTTP_SESSION_ID'])
  end

  def current_user
    @current_user ||= User.find_by(uuid: cookies.signed[:visitor_id])
  end
  
end
