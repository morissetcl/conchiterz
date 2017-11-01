require 'conchiterz'

describe Conchiterz::Feminize do
  it 'return an empty string if the initial string is empty' do
    expect(Conchiterz::Feminize.translate('')).to eql('')
  end
  it "feminize a word" do
    expect(Conchiterz::Feminize.translate('il est beau et joueur')).to eql('elle est belle et joueuse')
  end
  it 'masculanize a word' do
    expect(Conchiterz::Feminize.translate('elle est belle et nouvelle')).to eql('il est beau et nouveau')
  end
  it 'return words capitalized if there were capitalized' do
    expect(Conchiterz::Feminize.translate('Elle est Belle et Joueuse')).to eql('Il est Beau et Joueur')
  end
  it 'return words upcased if there were upcased' do
    expect(Conchiterz::Feminize.translate('Il est BEAU')).to eql('Elle est BELLE')
  end
end
