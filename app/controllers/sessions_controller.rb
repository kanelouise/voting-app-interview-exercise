class SessionsController < ApplicationController
  def create
    voter = Voter.find_by(email: params[:email].downcase)

    if voter &&
      voter.authenticate(params[:password]) &&
      voter.zip_code == params[:zip_code]

      session[:voter_id] = voter.id
      render json: { message: "Logged in", voter_id: voter.id }
    else
      #could make this more granular if we wanted to separate out which login param was the issue
      render json: { error: "Invalid email, password, or zip code" }, status: :unauthorized
    end
  end

  def destroy
    session.delete(:voter_id)
    render json: { message: "Logged out"}
  end
end
