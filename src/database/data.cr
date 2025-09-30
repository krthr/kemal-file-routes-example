require "json"

alias UserName = {title: String, first: String, last: String}
alias UserId = {name: String, value: String}
alias UserPicture = {large: String, medium: String, thumbnail: String}

alias User = {name: UserName, id: UserId, picture: UserPicture}

alias Data = {results: Array(User), info: {seed: String, results: Int32, page: Int32, version: String}}

module Database
  JSON_CONTENT = {{ `cat #{__DIR__ + "/data.json"}` }}

  def self.list : Array(User)
    JSON_CONTENT[:results]
  end

  def self.get(id : String)
    self.list.find { |user| user[:id][:value] == id }
  end
end
