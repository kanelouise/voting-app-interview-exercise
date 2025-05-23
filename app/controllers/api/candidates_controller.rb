module Api
  class CandidatesController < ApplicationController
    def index
      candidates = Candidate.all
      render json: candidates
    end
  end
end
