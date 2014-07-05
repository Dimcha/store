require 'spec_helper'
require 'store'

describe Store do
  it "should have a VERSION constant" do
    expect(subject.const_get('VERSION')).not_to be_empty
  end
end
