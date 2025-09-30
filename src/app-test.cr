require "kemal-file-routes"
require "./database/data.cr"

before_all do |env|
  env.response.content_type = "application/json"
end

register_routes

Kemal.run
