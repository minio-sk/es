require 'es/client'
require 'es/raw_client'

describe ES::Client do
  let(:dumper) { double(:Dumper) }
  let(:client) { double(:Client) }
  subject { described_class.new(dumper: dumper, client: client) }

  it 'passes serialized data to client' do
    data = {}
    serialized = 'serialized'
    response = :response
    dumper.should_receive(:dump).with(data).and_return(serialized)

    client.should_receive(:index).with('index/1', serialized).and_return(response)

    subject.index('index/1', data).should == response
  end
end
