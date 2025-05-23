module Api
  class VotersController < ApplicationController
    def create
      voter = Voter.new(voter_params)

      if voter.save
        session[:voter_id] = voter.id
        render json: { message: "Voter registered", voter_id: voter.id }, status: :created
      else
        #could make this more specific
        render json: { error: "Invalid email or zip code. Could not create account." }, status: :unprocessable_entity
      end
    end

    private

    def voter_params
      params[:email]&.downcase!
      params.permit(:email, :password, :zip_code)
    end
  end
end