module ES
  def self.copy_index(from_index, to_index, opts = {})
    scroll_timeout = opts.fetch(:scroll_timeout, '5m')
    scroll_size = opts.fetch(:scroll_size, 100)

    from = new(host: opts[:from_host])
    to = new(host: opts[:to_host])

    results = from.search(from_index, {query: {match_all: {}}}, {scroll: scroll_timeout, size: scroll_size})

    while results['hits']['hits'].any?
      requests = results['hits']['hits'].each_with_object([]) do |hit, requests|
        requests << {index: {_type: hit['_type'], _id: hit['id']}}
        requests << hit['_source']
      end

      to.bulk(requests, to_index)

      scroll_id = results['_scroll_id']
      results = from.scroll(scroll: scroll_timeout, scroll_id: scroll_id)
    end
  end
end