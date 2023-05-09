# Use TDD principles to build out name functionality for a Person.
# Here are the requirements:
# - Add a method to return the full name as a string. A full name includes
#   first, middle, and last name. If the middle name is missing, there shouldn't
#   have extra spaces.
# - Add a method to return a full name with a middle initial. If the middle name
#   is missing, there shouldn't be extra spaces or a period.
# - Add a method to return all initials. If the middle name is missing, the
#   initials should only have two characters.
#
# We've already sketched out the spec descriptions for the #full_name. Try
# building the specs for that method, watch them fail, then write the code to
# make them pass. Then move on to the other two methods, but this time you'll
# create the descriptions to match the requirements above.
require "rspec/autorun"
require "pry"
class Person
  def initialize(first_name:, middle_name: "", last_name:)
    @first_name = first_name
    @middle_name = middle_name
    @last_name = last_name
  end

  def full_name
    [@first_name, @middle_name, @last_name].compact.join(" ")
  end
  
  def full_name_with_middle_initial
    @middle_name = "#{@middle_name[0]}." if @middle_name
    [@first_name, @middle_name, @last_name].compact.join(" ")
  end

  def initials
    [@first_name[0], @middle_name[0], @last_name[0]].compact.join(".") + "."
  end
end

RSpec.describe Person do
  describe "#full_name" do
    it "concatenates first name, middle name, and last name with spaces" do
      person = Person.new(first_name: "John", middle_name: "Quincy", last_name: "Adams")
      expect(person.full_name).to eq("John Quincy Adams")
    end

    it "does not add extra spaces if middle name is missing" do
      person = Person.new(first_name: "John", last_name: "Adams")
      expect(person.full_name).to eq("John Adams")
    end
  end

  describe "#full_name_with_middle_initial" do
    it "concatenates first name, middle name initial, and last name with spaces" do
      person = Person.new(first_name: "John", middle_name: "Quincy", last_name: "Adams")
      expect(person.full_name_with_middle_initial).to eq("John Q. Adams")
    end

    it "does not add extra spaces or a period if middle name is missing" do
      person = Person.new(first_name: "John", last_name: "Adams")
      expect(person.full_name_with_middle_initial).to eq("John Adams")
    end
  end

  describe "#initials" do
    it "returns the first letter of each name" do
      person = Person.new(first_name: "John", middle_name: "Quincy", last_name: "Adams")
      expect(person.initials).to eq("J.Q.A.")
    end

    it "returns the first letter of each name without extra periods if middle name is missing" do
      person = Person.new(first_name: "John", last_name: "Adams")
      expect(person.initials).to eq("J.A.")
    end
  end
end


