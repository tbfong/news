require "sinatra"
require "sinatra/reloader"
require "geocoder"
require "forecast_io"
require "httparty"
def view(template); erb template.to_sym; end
before { puts "Parameters: #{params}" }                                     

# enter your Dark Sky API key here
ForecastIO.api_key = "d51d353173f631626954563c7998d849"

#variables


 
get "/" do

  # show a view that asks for the location
  view "search"
end

get "/news" do
results = Geocoder.search(params["q"])
    lat_long = results.first.coordinates # => [lat, long]
    lat= "#{lat_long[0]}"
    long= "#{lat_long[1]}"
    forecast = ForecastIO.forecast("#{lat}", "#{long}").to_hash
    @current_temperature = forecast["currently"]["temperature"]
    @conditions = forecast["currently"]["summary"]
    for day in forecast["daily"]["data"]
  puts "A high temperature of #{day["temperatureHigh"]} and #{day["summary"]}."
    end
    view "ask"
  # do everything else
end