require File.join(File.dirname(__FILE__), "..","lib", "api")
#require 'factory'

describe Api do
  it "should initialize" do 
		a = Api.new
		a.should be
  end
end
