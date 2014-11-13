require_relative 'client/errors'

class Moysklad::Client

  URL = 'https://online.moysklad.ru'

  def initialize login: nil, password: nil
    @client = Faraday.new URL
    @client.basic_auth login, password
  end

  def get path, params={}
    validate client.get path, params
  end

  def put path, data
    result = client.put do |req|
      req.url path
      req.headers['Content-Type'] = 'application/xml'
      req.headers['Accept'] = '*/*'
      req.body = data
    end
    validate result
  end

  def delete path
    validate client.delete path
  end

  private

  attr_reader :client

  def validate res
    return res.body if res.status == 200

    Moysklad::Client::Error.build res
  end

end
