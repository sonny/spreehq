require File.dirname(__FILE__) + '/../spec_helper'

describe Extension do
  before(:each) do
    @extension = Extension.new
  end

  it "should be valid" do
    @extension.should be_valid
  end
end
