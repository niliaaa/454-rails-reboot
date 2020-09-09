# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# CALL AN API AND UPDATE THE DB
# GET ALL 275
# set url to the api
# loop to call the api until the api response has no key "offset"
  # each loop
  # get data
  # -> key `records`
  # -> key `fields`
  # -> key `name`
  # create an artist instance => Artist.new
  # save it to the DB => instance.save
require 'open-uri'
require 'pry-byebug'

base_url = 'https://api.airtable.com/v0/appOnpFap3mruBMNc/artists?api_key=key5wiIECTI6NOYbO'
artists = JSON.parse(open(base_url).read)
offset = artists['offset']
# FIRST OFFSET

artists['records'].each do |data|
  Artist.create!(name: data['fields']['name'])
end

# CONCAT 2ND OFFSET WITH BASE URL
# LOOP TO 2ND OFFSET
while offset
  artists = JSON.parse(open("#{base_url}&offset=#{offset}").read)
  offset = artists['offset']
  artists['records'].each do |data|
    Artist.create!(name: data['fields']['name'])
  end
end
