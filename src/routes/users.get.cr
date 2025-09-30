define_handler do |env|
  Database.list.to_json
end
