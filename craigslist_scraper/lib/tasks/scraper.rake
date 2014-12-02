namespace :scraper do
  desc "Fetch Craigslist posts from 3taps"
  task scrape: :environment do
  	require 'open-uri'
require 'json'

# Set API token and URL
auth_token = "6409d97db61178122ccb8a843050cad3"
polling_url = "http://polling.3taps.com/poll"

# Specify request parameters
params = {
	auth_token: auth_token,
	anchor: 1556869091,
	source: "CRAIG", 
	category_group: "RRRR",
	category: "RHFR",
	'location.city' => "USA-NYM-BRL",
	retvals: "location,external_url,heading,body,timestamp,price,images,annotations"
}

# Prepare API request
uri = URI.parse(polling_url)
uri.query = URI.encode_www_form(params)

# Submit request
result = JSON.parse(open(uri).read)

# Display results to screen
# puts result["postings"].second["location"]["locality"]

# Store results in database
puts JSON.pretty_generate result["postings"]
# result["postings"].each do |posting|

# 	# Create new Post
# 	@post = Post.new
# 	@post.heading = posting["heading"]
# 	@post.body = posting["body"]
# 	@post.price = posting["price"]
# 	@post.neighborhood = posting["location"]["locality"]
# 	@post.external_url = posting["external_url"]
# 	@post.timestamp = posting["timestamp"]

# 	# Save Post
# 	@post.save 
# 	end
end

  desc "Destroy all posting data"
  task destroy_all_posts: :environment do
  	Post.destroy_all
  end

end
