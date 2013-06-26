require 'es/raw_client'
require 'es/client'
require 'oj'

describe ES::Client do
  let(:client) { double(:Client) }
  subject { described_class.new(client: client) }
  let(:raw_response) { '{}' }
  let(:response) { {} }
  let(:raw_data) { '{"a":1}' }
  let(:data) { {a: 1} }

  it 'serializes data for .create_index' do
    client.should_receive(:create_index).with('index/1', raw_data).and_return(raw_response)

    subject.create_index('index/1', data).should == response
  end

  it 'serializes data for .delete_index' do
    client.should_receive(:delete_index).with('index/1').and_return(raw_response)

    subject.delete_index('index/1').should == response
  end

  it 'serializes data for .bulk' do
    requests = [{a: 1}, 2, 3]
    client.should_receive(:bulk).with("{\"a\":1}\n2\n3\n", 'an_index').and_return(raw_response)

    subject.bulk(requests, 'an_index').should == response
  end

  it 'serializes data for .index' do
    client.should_receive(:index).with('index/1', raw_data).and_return(raw_response)

    subject.index('index/1', data).should == response
  end

  it 'serializes data for .get' do
    client.should_receive(:get).with('index/1').and_return(raw_response)

    subject.get('index/1').should == response
  end

  it 'serializes data for .search' do
    client.should_receive(:search).with('index/1', raw_data).and_return(raw_response)

    subject.search('index/1', data).should == response
  end

  it 'serializes data for .update' do
    client.should_receive(:update).with('index/1', raw_data).and_return(raw_response)

    subject.update('index/1', data).should == response
  end
end
