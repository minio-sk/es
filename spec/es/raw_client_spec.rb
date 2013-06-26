require 'es/raw_client'

describe ES::RawClient do
  let(:data) { {} }
  let(:response) { :response }
  let(:connection) { double(:Connection) }
  let(:subject) { described_class.new({connection: connection}) }

  context '.create_index' do
    it 'sends PUT to connection' do
      connection.should_receive(:request).with(:put, :an_index, data).and_return(response)

      subject.create_index(:an_index, data).should == response
    end
  end

  context '.delete_index' do
    it 'sends DELETE to connection' do
      connection.should_receive(:request).with(:delete, :an_index).and_return(response)

      subject.delete_index(:an_index).should == response
    end
  end

  context '.get' do
    it 'sends GET to connection' do
      connection.should_receive(:request).with(:get, 'index/1').and_return(response)

      subject.get('index/1').should == response
    end
  end

  context '.index' do
    it 'sends PUT to connection' do
      connection.should_receive(:request).with(:put, 'index/1', data).and_return(response)

      subject.index('index/1', data).should == response
    end
  end

  context '.search' do
    it 'sends POST to connection' do
      connection.should_receive(:request).with(:post, 'index/_search', data).and_return(response)

      subject.search('index', data).should == response
    end
  end

  context '.bulk' do
    it 'sends POST to connection' do
      connection.should_receive(:request).with(:post, '_bulk', data).and_return(response)

      subject.bulk(data).should == response
    end
  end

  context '.update' do
    it 'sends POST to connection' do
      connection.should_receive(:request).with(:post, 'index/1/_update', data).and_return(response)

      subject.update('index/1', data).should == response
    end
  end
end
