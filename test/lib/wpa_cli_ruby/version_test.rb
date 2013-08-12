require_relative '../../test_helper'

describe WpaCliRuby do
  it "must have a version" do
    refute WpaCliRuby::VERSION.nil?
  end
end
