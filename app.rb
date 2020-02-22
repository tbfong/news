require "sinatra"
require "sinatra/reloader"
require "geocoder"
require "forecast_io"
require "httparty"
def view(template); erb template.to_sym; end
before { puts "Parameters: #{params}" }                                     

# enter your Dark Sky API key here
ForecastIO.api_key = "d51d353173f631626954563c7998d849"
url = "https://newsapi.org/v2/top-headlines?country=us&apiKey=109eb1783fbe4c9b9ff2912a04d0354f"
news = HTTParty.get(url).parsed_response.to_hash

#variables


 
get "/" do

  # show a view that asks for the location
  view "search"
end

get "/news" do
results = Geocoder.search(params["q"])
url = "https://newsapi.org/v2/top-headlines?country=us&apiKey=109eb1783fbe4c9b9ff2912a04d0354f"
news = HTTParty.get(url).parsed_response.to_hash
    lat_long = results.first.coordinates # => [lat, long]
    lat= "#{lat_long[0]}"
    long= "#{lat_long[1]}"
    forecast = ForecastIO.forecast("#{lat}", "#{long}").to_hash
    @current_temperature = forecast["currently"]["temperature"]
    @conditions = forecast["currently"]["summary"]
    @forecast = forecast ["daily"]["data"]
    @paper = news["articles"]
    
  

    view "ask"
  # do everything else
end