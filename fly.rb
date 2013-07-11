#def get_flight (airports, last_airport_index = nil, airport_count = 0, previous_continent = nil, continent_already_switched = false)

=begin
def get_flight (airports, airport_count = 0, options = {})
  airports.each_with_index do |airport, index|
    unless options[:continent_already_switched] && options[:previous_continent] != airport[:continent]
      if airport_count == 3
        puts "#{airport[:code]} (#{airport[:continent]}, #{index}, #{airport_count})"
      else
        print "#{airport[:code]} (#{airport[:continent]}, #{index}, #{airport_count}) - " if airport_count > 1
        continent_switched = options[:previous_continent] == airport[:continent]
        get_flight airports, airport_count + 1, {last_airport_index: index,
                                               previous_continent: airport[:continent],
                                               continent_already_switched: continent_switched}
      end
    end
  end
end
=end

def get_all_flights(airports, visited_airports = [], continent_switched = nil)
  airports.each do |airport|
    next if visited_airports.include? airport[:code]
    next if continent_switched && airport[:continent] != continent_switched
    if visited_airports.length < 4
      switch_continent = airport[:continent] if continent_switched != airport[:continent]
      get_all_flights(airports, visited_airports + [airport[:code]], switch_continent)
    end
  end
  puts visited_airports.join(' - ') unless visited_airports.length == 1
end

# RUN

abort 'No input file provided.' unless File.exists?('./airports.dat')

start = Time.now

airports = Array.new

File.open('./airports.dat').each_line do |line|
  line.scan(/([A-Z]{3})\s([A-Z]{2})/) do |code, continent|
    airports << {code: code, continent: continent}
  end
end

get_all_flights airports

puts "Execution time: #{ Time.now - start }s"