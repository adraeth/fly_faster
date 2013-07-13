def get_all_flights(airports, visited_airports = {}, last_continent = nil, continent_switched = nil)
  airports.each do |code, continent|
    next if continent_switched && continent != last_continent
    next if visited_airports.has_key? code
    if visited_airports.length == 3
       puts visited_airports.merge({code => code}).values.join(' - ')
    else
      switch_continent = continent_switched || last_continent && last_continent != continent
      get_all_flights(airports, visited_airports.merge({code => code}), continent, switch_continent)
    end
  end
  puts visited_airports.values.join(' - ') unless visited_airports.length == 1
end

# RUN

abort 'No input file provided.' unless File.exists?('./airports.dat')

start = Time.now

airports = {}

File.open('./airports.dat').each_line do |line|
  line.scan(/([A-Z]{3})\s([A-Z]{2})/) do |code, continent|
    airports[code] = continent
  end
end

get_all_flights airports

puts "Execution time: #{ Time.now - start }s"