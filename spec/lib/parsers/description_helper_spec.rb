require 'spec_helper'

describe 'DescriptionHelper' do
  
  class DummyTestClass
    include DescriptionHelper
  end
  let(:dummy_object) { DummyTestClass.new }

  it 'it should return nil for inalid description' do
    descriptions = [" ", "", "|", "-"]
    expect(dummy_object.send(:parse_description, *[descriptions])).to be_nil
  end

  it 'should return valid description' do
    descriptions = [
      '2019年趣味幽默猜生肖,1358884不像看图找生肖,2019年看图猜生肖网站,2019看图找生肖83期,2019看图找生肖,2019看图找生肖109期,2019看图猜生肖买马,2019看图猜生肖买,2019全年看图找生肖图',
      "-" 
      ]
    expect(
      dummy_object.send(:parse_description, *[descriptions])
      ).to eq('2019年趣味幽默猜生肖,1358884不像看图找生肖,2019年看图猜生肖网站,2019看图找生肖83期,2019看图找生肖,2019看图找生肖109期,2019看图猜生肖买马,2019看图猜生肖买,2019全年看图找生肖图')
  end
end