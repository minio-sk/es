require 'es/connection'

describe ES::Connection do
  let(:data) { :data }
  let(:response_body) { :response }
  let(:response) { double(response_code: 200, body_str: response_body) }
  let(:driver) { double(:Driver) }

  subject { described_class.new('http://localhost:9200', driver) }

  it 'sends get request with url to driver' do
    driver.should_receive(:http_get).with('http://localhost:9200/index/1').and_return(response)

    subject.request(:get, 'index/1').should == response_body
  end

  it 'sends post request with url to driver' do
    driver.should_receive(:http_post).with('http://localhost:9200/index', data).and_return(response)

    subject.request(:post, 'index', data).should == response_body
  end

  it 'sends put request with url to driver' do
    driver.should_receive(:http_put).with('http://localhost:9200/index', data).and_return(response)

    subject.request(:put, 'index', data).should == response_body
  end

  it 'sends delete request with url to driver' do
    driver.should_receive(:http_delete).with('http://localhost:9200/index').and_return(response)

    subject.request(:delete, 'index').should == response_body
  end

  it 'throws error if response code is not 2XX' do
    error_response = double(response_code: 400)
    driver.should_receive(:http_post).and_return(error_response)

    expect { subject.request(:post, 'index/_search', data) }.to raise_error(ES::Connection::Error)
  end
end
