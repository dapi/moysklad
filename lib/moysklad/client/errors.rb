class Moysklad::Client
  class Errors
    def self.build res
      # Encoding::UndefinedConversionError
      # "\xD0" from ASCII-8BIT to UTF-8
      begin
        body = res.status==401 ? res.body.force_encoding('utf-8') : res.body
        Moysklad.logger.warn "Moyskad::Client: #{res.status}: #{res.env.url.to_s}\n#{body}"
      rescue Encoding::UndefinedConversionError
      end

      case res.status
      when 401
        raise UnauthorizedError.new res
      when 403
        raise ResourceForbidden.new res
      when 404
        raise NoResourceFound.new res.body
      when 405
        raise MethodNotAllowedError.new res
      when 500
        raise InternalServerError.new res
      when 502
        raise BadGatewayError.new res
      else
        raise ParsedError.new res
      end
    end
  end
end

class Moysklad::Client
  class Error < StandardError
    attr_reader :message

    def initialize mess
      @message = mess
    end

    def to_s
      message.encode('utf-8')
      # <?xml version="1.0" encoding="UTF-8"?> <error> <uid>kiiiosk@wannabemoscow</uid> <moment>20150609112728449</moment> <message>������������ ���� ���������� �������� ������������.</message> </error>
    rescue Encoding::CompatibilityError
      message.force_encoding('cp1251').encode('utf-8')
    end
  end

  class NoResourceFound < Error; end

  class HtmlParsedError < Error
    def initialize res
      @result  = res
      @message = "[#{res.status}] #{parse_title res.body}"
    end

    private

    def parse_title body
      doc = Nokogiri::HTML body
      # у ResourceForbidden есть <u>
      # у wrong_password <u> несколько
      # Можно ошибку разбирать более грамотно по свойствам type, message, description: http://i.gyazo.com/e9d5d08bd610882d87f39d9002cdf25a.png
      [doc.css('body').css('h1').text,doc.css('body').css('u').to_a.map(&:text).compact.last].join('; ')
    rescue => err
      Moysklad.logger.debug "Moyskad::Client parse error #{err}: #{body}"
      body.force_encoding('utf-8')
    end
  end

  class MethodNotAllowedError < HtmlParsedError
  end

  class UnauthorizedError < HtmlParsedError
  end

  class ResourceForbidden < HtmlParsedError
  end

  class ParsedError < Error
    def initialize result
      @status = result.status
      @result = result
      case result.headers['content-type']

      when /application\/xml/
        @error = Moysklad::Entities::Error.parse result.body
        @message = @error.message
      when /text\/html/
        doc = Nokogiri::HTML result.body
        @message = doc.css('body').css('h1').text
      else
        raise "Unknown content-type #{result.headers['content-type']} to parse error #{result.body}"
      end
    rescue => err
      @message = "error in init #{err}: #{result.body}"
    end

    attr_reader :error
  end


  class BadGatewayError < HtmlParsedError; end
  class InternalServerError < ParsedError; end
end
