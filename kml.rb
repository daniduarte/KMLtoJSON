
require 'rubygems'
require 'nokogiri'
require 'csv'
require 'awesome_print'
require 'json'

@doc = Nokogiri::XML File.open('map.kml')

puts '===================================='
puts '--- START ---'
puts '------------------------------------'

places = []

@doc.css('Placemark').each do |place|
  name = place.css('name').text.strip
  size = place.css('description').text.strip
  coords = place.css('coordinates').text.strip
  coords = coords.split ',0 '
  status = rand(1..2)

  points = []

  coords.each do |coord|
    coord = coord.split ','

    points << {
      lng: coord[0].to_f,
      lat: coord[1].to_f
    }
  end

  places << { name: name, size: size, price: '1000 uf', status: status, coords: points }
end

places = places.to_json

ap places

File.open('map_output.json', 'w') do |f| 
  f.write places

  puts '>> File created!'
end

puts '------------------------------------'
puts '--- END ---'
puts '===================================='

