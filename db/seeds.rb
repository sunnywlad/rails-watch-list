# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'uri'
require 'json'

puts "Cleaning database..."
Movie.destroy_all
puts "Database cleaned"

json_string = URI.open('https://tmdb.lewagon.com/movie/now_playing').read
data = JSON.parse(json_string)["results"]

data.each do |movie|
  Movie.create!(title: movie["original_title"],
                overview: movie["overview"],
                poster_url: "https://image.tmdb.org/t/p/w200#{movie["poster_path"]}",
                rating: movie["vote_average"].round(1))
  puts "#{Movie.last.title} created"
end

puts "Created #{Movie.count} movies"
