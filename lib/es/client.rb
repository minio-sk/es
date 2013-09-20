# TODO find a better way to wrap serialization to client
module ES
  class Client
    def initialize(opts = {})
      @dumper = opts[:dumper] || Oj
      @client = opts[:client] || begin
        RawClient.new(opts)
      end
    end

    def bulk(requests, path = nil)
      serialized = requests.map do |r|
        serialize(r) + "\n"
      end.join('')

      response = @client.bulk(serialized, path)

      @dumper.load(response)
    end

    def get(path)
      response = @client.get(path)
      @dumper.load(response)
    end

    def index(path, data)
      serialized = serialize(data)
      response = @client.index(path, serialized)
      @dumper.load(response)
    end

    def search(path, data, params = {})
      serialized = serialize(data)
      response = @client.search(path, serialized, params)
      @dumper.load(response)
    end

    def scroll(params = {})
      response = @client.scroll(params)
      @dumper.load(response)
    end

    def update(path, data)
      serialized = serialize(data)
      response = @client.update(path, serialized)
      @dumper.load(response)
    end

    def create_index(path, data)
      serialized = serialize(data)
      response = @client.create_index(path, serialized)
      @dumper.load(response)
    end

    def delete_index(path)
      response = @client.delete_index(path)
      @dumper.load(response)
    end

    def get_mapping(path)
      response = @client.get_mapping(path)
      @dumper.load(response)
    end

    private
    def serialize(data)
      @dumper.dump(data, mode: :compat)
    end
  end
end
