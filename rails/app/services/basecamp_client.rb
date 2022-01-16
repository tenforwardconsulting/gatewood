class BasecampClient
  include Httparty


  def headers
    {
      "Authorization": => "Bearer #{access_token}",
      "User-Agent": "Grandma Gatewood (brian@tenforwardconsulting.com)"
    }
  end

  def endpoint
    "https://3.basecampapi.com/"
  end
end