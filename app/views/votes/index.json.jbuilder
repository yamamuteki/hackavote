json.array!(@votes) do |vote|
  json.extract! vote, :id, :team_no, :category, :point
  json.url vote_url(vote, format: :json)
end
