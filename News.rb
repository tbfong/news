require "httparty"
url = "https://newsapi.org/v2/top-headlines?country=us&apiKey=109eb1783fbe4c9b9ff2912a04d0354f"
news = HTTParty.get(url).parsed_response.to_hash
# news is now a Hash you can pretty print (pp) and parse for your output

for title in news["articles"]
    puts "Here are the top headlines: #{title["title"]}.
    link: #{title["url"]}"
end

