require 'chbs'
require 'sinatra'

get '/' do
  options = {}
  count = 5
  chbs = Chbs::Generator.new(options)
  @passwords = []
  count.times do
    @passwords << chbs.generate
  end
  erb :index
end
