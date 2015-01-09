class ApplicationController < Sinatra::Base

  # set folder for templates to ../views, but make the path absolute
  set :views, File.expand_path('../../views', __FILE__)

  # don't enable logging when running tests
  configure :production, :development do
    enable :logging
  end

  get '/manifest' do
    content_type 'application/xml'
    File.read(File.expand_path('../../config/manifest.xml', __FILE__))
  end

  # params: address is required
  post '/detect_operator' do
    content_type 'application/json'
    tel = Tel.new(params[:address])
    "{\"result\": \"#{tel.code}\"}"
  end

end
