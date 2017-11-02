require 'conchiterz'

describe Conchiterz::Feminize do
  it 'return an empty string if the initial string is empty' do
    expect(Conchiterz::Feminize.translate('')).to eql('')
  end
  it "feminize a word" do
    expect(Conchiterz::Feminize.translate('il est beau et joueur')).to eql('elle est belle et joueuse')
  end
  it 'masculanize a word' do
    expect(Conchiterz::Feminize.translate('je suis belle et elle est pareille')).to eql('je suis beau et il est pareil')
  end
  it 'return words capitalized if there were capitalized' do
    expect(Conchiterz::Feminize.translate('Elle est Belle et Joueuse')).to eql('Il est Beau et Joueur')
  end
  it 'return words upcased if there were upcased' do
    expect(Conchiterz::Feminize.translate('Il est BEAU')).to eql('Elle est BELLE')
  end
  it 'return string with the same punctuation' do
    expect(Conchiterz::Feminize.translate('Il est BEAU, vraiment beau')).to eql('Elle est BELLE, vraiment belle')
    expect(Conchiterz::Feminize.translate('Elle est Inscrite, vraiment inscrite')).to eql('Il est Inscrit, vraiment inscrit')
  end
  it 'handle word with only one letter' do
    expect(Conchiterz::Feminize.translate('M Lawson')).to eql('Mme Lawson')
  end
end
