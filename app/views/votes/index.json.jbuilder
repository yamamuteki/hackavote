json.array!(@votes) do |vote|
  json.extract! vote, :id, :team_no, :point1, :point2, :point3
  json.url vote_url(vote, format: :json)
end
