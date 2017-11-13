require 'faraday'

require_relative 'client/errors'

class Moysklad::Client

  # URL = 'https://online.moysklad.ru'
  URL  ='https://online.moysklad.ru/api/remap/1.1/'

  def initialize login: nil, password: nil
    @client = Faraday.new URL
    @client.basic_auth login, password
  end

  def download(path, filename)
    response = client.get path
    File.open(filename, 'wb') { |fp| fp.write(response.body) }
  end

  def get path, params={}
    logger.debug "Client: GET #{path} #{params}"
    parse_response client.get path, params
  end

  def post path, data
    logger.debug "Client: POST #{path}"
    result = client.post do |req|
      req.url path
      req.headers['Content-Type'] = 'application/json'
      req.headers['Accept'] = '*/*'
      req.body = data
    end
    parse_response result
  end

  def put path, data
    logger.debug "Client: PUT #{path}"
    result = client.put do |req|
      req.url path
      req.headers['Content-Type'] = 'application/json'
      req.headers['Accept'] = '*/*'
      req.body = data
    end
    parse_response result
  end

  def delete path
    logger.debug "Client: DELETE #{path}"
    result = client.delete do |req|
      req.url path
      req.headers['Content-Type'] = 'application/json'
      req.headers['Accept'] = '*/*'
    end
    parse_response result
  end

  private

  attr_reader :client

  def logger
    Moysklad.logger
  end

  def parse_response res
    Moysklad.logger.debug "Response [#{res.status}]: #{res.body}"

    if res.status == 200
      return if res.body.blank?
      JSON.parse res.body
    else
      Moysklad::Client::Errors.build res
    end
  end
end
