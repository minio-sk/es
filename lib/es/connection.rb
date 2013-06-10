module ES
  class Connection
    OK_HTTP_CODES = [200, 201]

    def initialize(host, driver)
      @host = host
      @driver = driver
    end

    def request(method, path, data = nil)
      response = translate_request(method, "#{@host}/#{path}", data)
      raise Error.new(response) unless OK_HTTP_CODES.include?(response.response_code)
      response.body_str
    end

    class Error < StandardError
      def initialize(response)
        super(response)
      end
    end

    private
    def translate_request(method, url, data)
      case method
        when :get
          @driver.http_get(url)
        when :put
          @driver.http_put(url, data)
        when :post
          @driver.http_post(url, data)
        when :delete
          @driver.http_post(url)
      end
    end
  end
end
