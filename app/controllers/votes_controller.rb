def create
  return render json: { error: "Already voted" }, status: :forbidden if current_voter.vote.present?

  if params[:write_in_candidate].present?
    return render json: { error: "You already submitted a write-in candidate." }, status: :forbidden if current_voter.write_in_candidate.present?
    return render json: { error: "Sorry, maximum write-in candidates reached." }, status: :unprocessable_entity if Candidate.count >= 10

    candidate_name = params[:write_in_candidate].strip.titleize
    return render json: { error: "Write-in name can't be blank" }, status: :unprocessable_entity if candidate_name.blank?

    candidate = Candidate.where("lower(name) = ?", candidate_name.downcase).first_or_create(name: candidate_name)

    unless candidate.persisted?
      return render json: { error: "Could not create candidate" }, status: :unprocessable_entity
    end

    unless current_voter.update(write_in_candidate: candidate)
      return render json: { error: "Could not associate write-in with voter" }, status: :unprocessable_entity
    end
  else
    candidate = Candidate.find_by(id: params[:candidate_id])
    return render json: { error: "Candidate not found" }, status: :not_found unless candidate
  end

  Vote.create!(voter: current_voter, candidate: candidate)
  render json: { message: "Vote recorded!" }, status: :created
end

