require './recommendation'

if ARGV.empty? || !File.exist?(ARGV[0])
  puts 'Missing input file or wrong path'
  exit
end

file = CSV.read(ARGV[0])
header = file.shift
unless header.eql?(['userId;productId'])
  puts 'File header mismatch'
  exit
end

users = {}
file.each do |line|
  data = line[0].split(';')
  users[data[0].to_i] ||= User.new(id: data[0].to_i)
  users[data[0].to_i].products << data[1].to_i
end
users.each do |_id, user|
  user.set_signature!
end

engine = Recommendation::Engine.new(users.values)

puts 'Welcome to the Recommendation Engine'
puts 'Use an empty input to exit'
print 'Enter User ID: '
while id = STDIN.gets.to_i
  exit if id.zero?
  unless users[id].nil?
    recommendation = engine.recommendation_for(users[id])
    puts "Product Recommendation for User ##{id} is: #{!recommendation.empty? ? recommendation : 'None'}"
  else
    puts "User doesn't exist"
  end
  print 'Enter User ID: '
end
