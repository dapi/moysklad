class Moysklad::Client

  Moysklad_URL = 'https://online.moysklad.ru'

  def initialize login: nil, password: nil
    @client = Faraday.new Moysklad_URL
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
    Moysklad.logger.debug "Moyskad::Client: #{res.status}: #{res.body}"
    return res.body if res.status == 200

    case res.status
    when 405
      raise MethodNotAllowedError.new res
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

  class MethodNotAllowedError < Error
    attr_reader :message
    alias :message :to_s
    def initialize res
      @result = res
      doc = Nokogiri::HTML(res.body)
      text = doc.css('body').css('h1').text

      @message = text
    rescue => err
      Moysklad.logger.debug "Moyskad::Client parse error #{err}: #{res.body}"
      @message = "#{err}: #{res}"
    end

  end

  class ParsedError < Error
    attr_reader :message
    alias :message :to_s
    def initialize result
      @status = result.status
      @result = result
      @error = Moysklad::Entities::Error.parse result.body
      @message = @error.message
    rescue => err
      @message = "#{err}: #{result}"
    end

    attr_reader :error
  end
end

