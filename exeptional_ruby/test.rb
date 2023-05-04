begin
puts "Confirm (y/n)"
answer = gets.chomp
end until %w[y n].include?(answer)
