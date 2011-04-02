require 'spec_helper'

describe 'Comics' do
  include Rack::Test::Methods
  def app
    @app ||= Sinatra::Application
  end

  it 'render the index' do
    get '/comics'
    last_response.should be_successful
  end

  include Rack::Test::Methods
  def app
    @app ||= Sinatra::Application
  end

  before do
    @comic = Comics.keys.first
  end

  it 'renders an RSS feed' do
    get "/comics/#{@comic}.rss"
    last_response.should be_successful
    last_response.content_type.should == 'application/rss+xml;charset=utf-8'
  end

  it 'renders a PNG image' do
    date = Date.new 2010, 4, 12

    get "/comics/#{@comic}.rss"
    last_response.should be_successful
    last_response.content_type.should == 'application/rss+xml;charset=utf-8'
  end
end
