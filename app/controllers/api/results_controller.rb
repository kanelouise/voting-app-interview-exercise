module Api
  class ResultsController < ApplicationController
    def index
      results = Candidate
        .left_joins(:votes)
        .group(:id)
        .select("candidates.*, COUNT(votes.id) as votes_count")
        .map do |c|
          {
            id: c.id,
            name: c.name,
            votes: c.votes_count.to_i
          }
        end

      render json: results
    end
  end
end