def warn(message)
  raise message
end

def divide(a, b)
  if b.zero?
    warn "Division by zero is not allowed. Returning nil."
    return nil
  end

  a / b
end

result = divide(10, 2)
puts "Result: #{result}" # Output: Result: 5

result = divide(10, 0)
puts "Result: #{result}" # Output: Result:
