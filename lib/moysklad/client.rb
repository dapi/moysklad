require 'faraday'

require_relative 'client/errors'

class Moysklad::Client

  # URL = 'https://online.moysklad.ru'
  URL  ='https://online.moysklad.ru/api/remap/1.1/'

  def initialize login: nil, password: nil
    @client = Faraday.new URL
    @client.basic_auth login, password
  end

  def get path, params={}
    logger.debug "Client: GET #{path} #{params}"
    parse_response client.get path, params
  end

  def put path, data
    logger.debug "Client: PUT #{path}"
    result = client.put do |req|
      req.url path
      req.headers['Content-Type'] = 'application/xml'
      req.headers['Accept'] = '*/*'
      req.body = data
    end
    parse_response result
  end

  def delete path
    parse_response client.delete path
  end

  private

  attr_reader :client

  def logger
    Moysklad.logger
  end

  def parse_response res
    if res.status == 200
      JSON.parse res.body
    else
      Moysklad::Client::Errors.build res
    end
  end
end
