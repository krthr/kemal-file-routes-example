define_handler do |env|
  id = env.params.url["id"]
  user = Database.get(id)

  halt(env, status_code: 404, response: "Not Found") if user.nil?

  user.to_json
end
