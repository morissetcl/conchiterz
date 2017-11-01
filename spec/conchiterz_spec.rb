require 'conchiterz'

describe Conchiterz::Feminize do
  it "feminize a word" do
    expect(Conchiterz::Feminize.translate("beau et cool")).to eql("belle et cool")
  end
  it "masculanize a word" do
    expect(Conchiterz::Feminize.translate("belle et cool")).to eql("beau et cool")
  end
end
