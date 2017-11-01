require 'conchiterz'

describe Conchiterz::Feminize do
  it "feminize a word" do
    expect(Conchiterz::Feminize.translate("il est beau et joueur")).to eql("elle est belle et joueuse")
  end
  it "masculanize a word" do
    expect(Conchiterz::Feminize.translate("elle est belle et joueuse")).to eql("il est beau et joueur")
  end
  it "insensitive", :focus do
    expect(Conchiterz::Feminize.translate("Elle est Belle et Joueuse")).to eql("Il est Beau et Joueur")
  end
end
