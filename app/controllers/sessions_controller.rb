class SessionsController < ApplicationController
  def create
    Rails.logger.info "Params: #{params.inspect}"

    email = params[:email]&.downcase
    password = params[:password]
    zip_code = params[:zip_code]

    voter = Voter.find_by(email: email)

    if voter
      if voter.authenticate(password) && voter.zip_code == zip_code
        voter.authenticate(params[:password]) &&
        voter.zip_code == params[:zip_code]

        session[:voter_id] = voter.id
        render json: { message: "Logged in", voter_id: voter.id }
      else
        #could make this more specific if we wanted to separate out which login param was the issue
        render json: { error: "Invalid email, password, or zip code. Could not log in." }, status: :unauthorized
      end

    else
      voter = Voter.new(email:email, password: password, zip_code: zip_code)

      if voter.save
        session[:voter_id] = voter.id
        render json: { message: "New voter created", voter_id: voter.id }
      else
        #could make this more specific as well
        render json: { error: "Invalid email, password, or zip code. Could not create account."}
      end
    end
  end

  def destroy
    session.delete(:voter_id)
    render json: { message: "Logged out"}
  end
end