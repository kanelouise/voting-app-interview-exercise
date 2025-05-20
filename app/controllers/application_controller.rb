class ApplicationController < ActionController::Base
  protect_from_forgery with: exception

  helper_method :current_voter

  def current_voter
    @current_voter ||=Voter.find_by(id: session[:voter_id]) if session[:voter_id]
  end
end
