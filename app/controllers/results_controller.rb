class ResultsController < ApplicationController
  def index
    results = Candidate
    .left_joins(:votes)
    .group(:id)
    .select("candidates.*, COUNT(votes.id) as votes_count")

    render json: results.as_json(methods: :votes_count)
  end
end
