class Moysklad::Client
  class Errors
    def self.build
      Moysklad.logger.warn "Moyskad::Client: #{res.status}: #{res.env.url.to_s}\n#{res.body}"

      case res.status
      when 405
        raise MethodNotAllowedError.new res
      when 401 
        raise UnauthorizedError.new res
      when 404 
        raise NoResourceFound.new res.body
      when 500 
        raise ParsedError.new(res)
      else 
        raise ParsedError.new(res)
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
      message
    end
  end

  class NoResourceFound < Error; end

  class HtmlParsedError < Error
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

  class MethodNotAllowedError < HtmlParsedError
  end

  class UnauthorizedError < HtmlParsedError
  end

  class ParsedError < Error
    def initialize result
      @status = result.status
      @result = result
      @error = Moysklad::Entities::Error.parse result.body
      @message = @error.message
    rescue => err
      @message = "error in init #{err}: #{result.body}"
    end

    attr_reader :error
  end
end
