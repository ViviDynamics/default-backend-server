# app.ru
require 'sinatra'

class DefaultBackendServer < Sinatra::Base
  set :public_folder, __dir__ + '/static'
  NOT_FOUND_PAGE = File.read(File.join('public', '404.html'))

  get '/health-check/ping' do
    status 200
    body "pong"
  end

  get /.*/ do
    status 404
    NOT_FOUND_PAGE
  end
end

run DefaultBackendServer.run!
