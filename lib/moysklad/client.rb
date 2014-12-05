require 'faraday'

require_relative 'client/errors'

class Moysklad::Client

  URL = 'https://online.moysklad.ru'

  def initialize login: nil, password: nil
    @client = Faraday.new URL
    @client.basic_auth login, password
  end

  def get path, params={}
    logger.debug "Client: GET #{path} #{params}"
    validate client.get path, params
  end

  def put path, data
    logger.debug "Client: PUT #{path}"
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

  def logger
    Moysklad.logger
  end

  def validate res
    return res.body if res.status == 200

    Moysklad::Client::Errors.build res
  end

end
