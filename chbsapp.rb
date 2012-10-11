require 'chbs'
require 'json'
require 'sinatra'

set :static_cache_control, [:public, :max_age => 300]
before do
  cache_control :public, :must_revalidate, :max_age => 60
end

get '/' do
  @corpora = Chbs.included_corpora
  erb :index
end
get '/index.js' do
  coffee :index
end
get '/passphrases' do
  options = {}
  [:min_length, :max_length, :min_rank, :max_rank, :num_words].each do |int|
    if params[int.to_s]
      options[int] = params[int.to_s].to_i
    end
  end
  [:separator].each do |str|
    if params[str.to_s]
      options[str] = params[str.to_s]
    end
  end
  count = 5
  if params['count']
    pcount = params['count'].to_i
    # Constrain the count to 1-20.  Don't let the user ask us to do infinite
    # work.
    count = [1,[20,pcount].min].max
  end
  chbs = Chbs::Generator.new(options)
  passphrases = []
  count.times do
    passphrases << chbs.generate
  end
  cache_control :no_cache
  content_type :json
  passphrases.to_json
end
