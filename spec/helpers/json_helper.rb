# spec/support/json_helper.rb
module JsonHelper
  def json
    JSON.parse(response.body)
  end
end
