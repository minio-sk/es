module ES
  class Client
    def initialize(opts = {})
      @host = opts[:host] || 'http://localhost:9200'
      @backend = opts[:backend] || Curl
      @serializer = opts[:serializer] || Oj
    end

    def create_index(name, definition)
      http_put(url(name), serialize(definition))
    end

    def delete_index(name)
      http_delete(url(name))
    end

    def bulk(requests, path = nil)
      serialized_requests = requests.collect do |request|
        serialize(request) + "\n"
      end.join('')

      http_post(url(path, :bulk), serialized_requests)
    end

    def index(path, data)
      http_put(url(path), serialize(data))
    end

    def search(path, query)
      http_post(url(path, :search), serialize(query))
    end

    private
    def url(path, action = nil)
      root = path ? "#{@host}/#{path}" : @host
      action ? "#{root}/_#{action}" : root
    end

    def http_put(url, data)
      # TODO refactor
      response = @backend.put(url, data)
      if [200, 201].include?(response.response_code)
        @serializer.load(response.body_str)
      else
        raise StandardError.new(response.body_str)
      end
    end

    def http_post(url, data)
      # TODO refactor
      response = @backend.post(url, data)
      if response.response_code == 200
        @serializer.load(response.body_str)
      else
        raise StandardError.new(response.body_str)
      end
    end

    def http_delete(url)
      # TODO refactor
      response = @backend.delete(url)
      if response.response_code == 200
        @serializer.load(response.body_str)
      else
        raise StandardError.new(response.body_str)
      end
    end

    def serialize(data)
      @serializer.dump(data.as_json)
    end
  end
end