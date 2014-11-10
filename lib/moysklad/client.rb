class Moysklad::Client

  Moysklad_URL = 'https://online.moysklad.ru'

  def initialize login: nil, password: nil
    @client = Faraday.new Moysklad_URL
    @client.basic_auth login, password
  end

  delegate :basic_auth, to: :client

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
    case res.status
    when 200
      res.body
    when 405
      doc = Nokogiri::HTML(res.body)
      text = doc.css('body').css('h1').text

      raise Error.new "405 - #{text}"
    when 404 
      raise NoResourceFound
    when 500 
      raise ParsedError.new(res)
    else 
      raise ParsedError.new(res)
    end
  end

  class Error < StandardError; end
  class NoResourceFound < Error; end

  class ParsedError < Error
    def initialize result
      @status = result.status
      @result = result
      @error = Moysklad::Entities::Error.parse result.body
    end

    def message
      @error.message
    end

    attr_reader :error
  end
end

