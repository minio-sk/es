module ES
  class RawClient
    def initialize(opts = {})
      @connection = opts[:connection] || begin
        host = opts[:host] || 'http://localhost:9200'
        driver = opts[:driver] || Curl::Easy
        Connection.new(host, driver)
      end
    end

    def create_index(name, definition)
      @connection.request(:put, name, definition)
    end

    def delete_index(name)
      @connection.request(:delete, name)
    end

    def get(path)
      @connection.request(:get, path)
    end

    def index(path, data)
      @connection.request(:put, path, data)
    end

    def search(path, query, params = {})
      @connection.request(:post, action_path(path, :search, params), query)
    end

    def scroll(params = {})
      @connection.request(:get, action_path(nil, 'search/scroll', params))
    end

    def update(path, data)
      @connection.request(:post, action_path(path, :update), data)
    end

    def bulk(requests, path = nil)
      @connection.request(:post, action_path(path, :bulk), requests)
    end

    def get_mapping(path)
      @connection.request(:get, action_path(path, :mapping))
    end

    private
    def action_path(path, action, params = {})
      full_path = path ? "#{path}/_#{action}" : "_#{action}"
      params.any? ? "#{full_path}?#{serialize_params(params)}" : full_path
    end

    def serialize_params(params)
      params.map { |k, v| "#{k}=#{v}" }.join('&')
    end
  end
end
