json.array!(@sources) do |source|
  json.extract! source, :id, :url
  json.url source_url(source, format: :json)
end
