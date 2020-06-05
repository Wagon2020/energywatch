json.array! @smart_plugs do |plug|
  json.extract! plug, :id, :actual, :daily
end

