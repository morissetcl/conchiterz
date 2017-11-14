require 'conchiterz'

describe Conchiterz do
  it 'return an empty string if the initial string is empty' do
    expect(Conchiterz.translate('')).to eql('')
  end
  it "feminize a word" do
    expect(Conchiterz.translate('il est beau et joueur')).to eql('elle est belle et joueuse')
  end
  it 'masculanize a word' do
    expect(Conchiterz.translate('je suis belle et elle est pareille')).to eql('je suis beau et il est pareil')
  end
  it 'return words capitalized if there were capitalized' do
    expect(Conchiterz.translate('Elle est Belle et Joueuse')).to eql('Il est Beau et Joueur')
  end
  it 'return words upcased if there were upcased' do
    expect(Conchiterz.translate('Il est BEAU')).to eql('Elle est BELLE')
  end
  it 'return string with the same punctuation' do
    expect(Conchiterz.translate('Il est BEAU, vraiment beau')).to eql('Elle est BELLE, vraiment belle')
    expect(Conchiterz.translate('Elle est Inscrite, vraiment inscrite')).to eql('Il est Inscrit, vraiment inscrit')
  end
  it 'handle word with only one letter' do
    expect(Conchiterz.translate('M Lawson')).to eql('Mme Lawson')
  end
  it 'handle word with accent and other special character' do
    expect(Conchiterz.translate("Merci, d'être inscrite, ça vô, c'est cool")).to eql("Merci, d'être inscrit, ça vô, c'est cool")
  end
end
