def test_faliure
  begin
    fail "Oops";
  rescue => error
    raise if error.message != "Oops"
  end
end

test_faliure
