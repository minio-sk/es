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

    def search(path, query)
      @connection.request(:post, action_path(path, :search), query)
    end

    def update(path, data)
      @connection.request(:post, action_path(path, :update), data)
    end

    def bulk(requests, path = nil)
      @connection.request(:post, action_path(path, :bulk), requests)
    end

    private
    def action_path(path, action)
      path ? "#{path}/_#{action}" : "_#{action}"
    end
  end
end
