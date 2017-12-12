require 'conchiterz'

describe Conchiterz do
  it 'return an empty string if the initial string is empty' do
    expect(Conchiterz.translate('', true)).to eql('')
  end
  it "feminize a word" do
    expect(Conchiterz.translate('il est beau et joueur', true)).to eql('elle est belle et joueuse')
  end
  it 'does not feminize sentence if switch trigger is false' do
    expect(Conchiterz.translate('je suis beau', false)).to eql('je suis beau')
  end
  it 'return words capitalized and translated if there were capitalized' do
    expect(Conchiterz.translate('Il est Beau et Joueur', true)).to eql('Elle est Belle et Joueuse')
  end
  it 'return words upcased and translated if there were upcased' do
    expect(Conchiterz.translate('Il est BEAU', true)).to eql('Elle est BELLE')
  end
  it 'return string with the same punctuation' do
    expect(Conchiterz.translate('Il est BEAU, vraiment beau', false)).to eql('Il est BEAU, vraiment beau')
  end
  it 'switch word with accent and other special character' do
    expect(Conchiterz.translate("Merci, d'être inscrit, ç'est en août que ça commence.", true)).to eql("Merci, d'être inscrite, ç'est en août que ça commence.")
  end
  it 'translate word with only one letter' do
    expect(Conchiterz.translate('M Lawson', true)).to eql('Mme Lawson')
  end
  it 'does not translate sentence if the switch trigger is set to false' do
    expect(Conchiterz.translate('M Lawson', false)).to eql('M Lawson')
  end

  describe Conchiterz::StringMethods do

    before :all do
      Conchiterz.monkey_patch(String)
      @masculin = 'Bravo vous êtes inscrit.'
    end

    it "monkey_patch switch of the same way than without" do
      expect( @masculin.conchiterz(true)).to eq(Conchiterz.translate(@masculin, true))
      expect( @masculin.conchiterz(false)).to eq(Conchiterz.translate(@masculin, false))
    end
  end
end
