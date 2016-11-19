require 'json'

class User

  ENDPOINT = 'http://freegeoip.net/json/'

  def initialize
    ip_address = `curl #{ENDPOINT}`
    @json = JSON.parse(ip_address)
  end

  def latitude
    @json['latitude']
  end

  def longitude
    @json['longitude']
  end

  def coords
    [latitude, longitude]
  end

end