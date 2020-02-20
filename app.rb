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


 forecast = ForecastIO.forecast(42.0574063,-87.6722787).to_hash

get "/" do

  # show a view that asks for the location
  view "search"
end

get "/news" do
results = Geocoder.search(params["q"])
    lat_long = results.first.coordinates # => [lat, long]
    @latlong = "#{lat_long[0]}, #{lat_long[1]}"
    @current_temperature = forecast["currently"]["temperature"]
    @conditions = forecast["currently"]["summary"]
    view "ask"
  # do everything else
end