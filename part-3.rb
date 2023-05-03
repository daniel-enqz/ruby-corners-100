require 'English'
puts $!.inspect
begin
  raise "Oops"
rescue
  puts $!.inspect
  puts $ERROR_INFO.inspect
end
puts $!.inspect
