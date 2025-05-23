module Api
  class VotesController < ApplicationController
    before_action :require_login

    def create
      #check if user already voted
      return render json: { error: "Already voted" }, status: :forbidden if current_voter.vote.present?
      
      if params[:write_in_candidate].present?
        
        #check for 10 or greater write-in options
        return render json: { error: "Sorry, maximum write-in candidates reached, yours can't be added." }, status: :unprocessable_entity if Candidate.count >= 10

        candidate_name = params[:write_in_candidate].strip.titleize

        #check for blank "write-in"
        return render json: { error: "Write-in name can't be blank" }, status: :unprocessable_entity if candidate_name.blank? 
      
        candidate = Candidate.find_or_create_by(name: candidate_name)
        current_voter.update(write_in_candidate: candidate)
        #could add validation steps here to ensure the Candidate was created and current_voter updated
      else
        candidate = Candidate.find_by(id: params[:candidate_id])
        return render json: { error: "Candidate not found" }, status: :not_found unless candidate
      end

      vote = Vote.new(voter: current_voter, candidate: candidate)
      if vote.save
      render json: { message: "Vote recorded!" }, status: :created
      else
        render json: { error: "Unable to record vote."}, status: unprocessable_entity
      end
    end

    private

    def require_login
      unless current_voter
        render json: { error: "Not logged in"}, status: :unauthorized
      end
    end

    def vote_params
      params.permit(:candidate_id, :write_in_candidate)
    end
  end
end