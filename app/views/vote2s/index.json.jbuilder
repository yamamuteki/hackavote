json.array!(@vote2s) do |vote2|
  json.extract! vote2, :id, :team_no, :point1, :point2, :point3
  json.url vote2_url(vote2, format: :json)
end
