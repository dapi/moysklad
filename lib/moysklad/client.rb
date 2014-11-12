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
    return res.body if res.status == 200
    Moysklad.logger.warn "Moyskad::Client: #{res.status}: #{res.env.url.to_s}\n#{res.body}"

    case res.status
    when 405
      raise MethodNotAllowedError.new res
    when 404 
      raise NoResourceFound.new res.body
    when 500 
      raise ParsedError.new(res)
    else 
      raise ParsedError.new(res)
    end
  end

  class Error < StandardError
    attr_reader :message

    def initialize mess
      @message = mess
    end

    def to_s
      message
    end
  end

  class NoResourceFound < Error; end

  class MethodNotAllowedError < Error
    def initialize res
      @result = res
      @message = parse_title res.body
    end

    private

    def parse_title body
      doc = Nokogiri::HTML body
      doc.css('body').css('h1').text
    rescue => err
      Moysklad.logger.debug "Moyskad::Client parse error #{err}: #{res.body}"
      body
    end
  end

  class ParsedError < Error
    def initialize result
      @status = result.status
      @result = result
      @error = Moysklad::Entities::Error.parse result.body
      @message = @error.message
    rescue => err
      @message = "error in init #{err}: #{result}"
    end

    attr_reader :error
  end
end

