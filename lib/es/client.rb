module ES
  class Client
    def initialize(opts = {})
      @dumper = opts[:dumper] || Oj
      @client = opts[:client] || RawClient.new(opts)
    end

    def index(path, data)
      @client.index(path, @dumper.dump(data))
    end
  end
end
