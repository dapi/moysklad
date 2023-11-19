require 'faraday'
require 'faraday/detailed_logger'
require 'faraday_curl'
require 'faraday/gzip'

require_relative 'client/errors'

class Moysklad::Client
  URL  ='https://api.moysklad.ru/api/remap/1.2/'

  def initialize login: nil, password: nil, logger: nil
    @client = Faraday.new URL do |conn|
      unless logger.nil?
        conn.response :detailed_logger, logger
        conn.request :curl, logger, :info
      end
      conn.request :gzip

      conn.options.timeout = ENV.fetch('MOYSKLAD_HTTP_TIMEOUT', 120)
      if Faraday::VERSION.split('.').first.to_i < 2
        conn.request(:basic_auth, login, password)
      else
        conn.request(:authorization, :basic, login, password)
      end
    end
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
    body = res.body
    Moysklad.logger.debug "Response [#{res.status}] with body #{body}"

    if res.status == 200
      return if body.blank?
      JSON.parse body
    else
      Moysklad::Client::Errors.build res
    end
  end
end
