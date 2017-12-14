require 'conchiterz'

describe Conchiterz do
  it 'return an empty string if the initial string is nil' do
    expect(Conchiterz.translate(nil, true)).to eql(nil)
  end
  it 'return an empty string if the initial string is empty' do
    expect(Conchiterz.translate('', true)).to eql('')
  end
  it "feminize words" do
    expect(Conchiterz.translate('il est joyeux et joueur', true)).to eql('elle est joyeuse et joueuse')
  end
  it 'does not feminize sentence if switch trigger is false' do
    expect(Conchiterz.translate('je suis joyeux', false)).to eql('je suis joyeux')
  end
  it 'return words capitalized and translated if there were capitalized' do
    expect(Conchiterz.translate('Il est Joyeux et Joueur', true)).to eql('Elle est Joyeuse et Joueuse')
  end
  it 'return words upcased and translated if there were upcased' do
    expect(Conchiterz.translate('Il est JOYEUX', true)).to eql('Elle est JOYEUSE')
  end
  it 'return string with the same punctuation' do
    expect(Conchiterz.translate('Il est JOYEUX, vraiment joyeux', false)).to eql('Il est JOYEUX, vraiment joyeux')
  end
  it 'handle word with special character as accent' do
    expect(Conchiterz.translate("Merci, d'être inscrit, ç'est en août que ça commence", true)).to eql("Merci, d'être inscrite, ç'est en août que ça commence")
  end
  it 'Punctuation: handle sentence with colon and semicolon' do
    expect(Conchiterz.translate("Merci, d'être inscrit, ç'est en août que ça commence;", true)).to eql("Merci, d'être inscrite, ç'est en août que ça commence;")
  end
  it 'Punctuation: handle sentence with dot and bang!' do
    expect(Conchiterz.translate("Merci, d'être inscrit! ç'est en août que ça commence.", true)).to eql("Merci, d'être inscrite! ç'est en août que ça commence.")
  end
  it 'translate word with only one letter' do
    expect(Conchiterz.translate('M Lawson', true)).to eql('Mme Lawson')
  end
  it 'does not translate sentence if the switch trigger is set to false' do
    expect(Conchiterz.translate('M Lawson', false)).to eql('M Lawson')
  end

  it 'one word escaped: does not change a word which is included in escape array' do
    expect(Conchiterz.translate("Martin, vous êtes beau, nous vous souhaitons un joyeux anniversaire", true, escape = ['joyeux'])).to eql('Martin, vous êtes belle, nous vous souhaitons un joyeux anniversaire')
  end

  it 'several words escaped: does not change words which are included in escape array' do
    expect(Conchiterz.translate("Martin, bon vent, vous êtes beau, par conséquent nous vous souhaitons un joyeux anniversaire et un bon réveillon!", true, escape = ['joyeux', 'bon'])).to eql('Martin, bon vent, vous êtes belle, par conséquent nous vous souhaitons un joyeux anniversaire et un bon réveillon!')
  end

  describe Conchiterz::StringMethods do

    before :all do
      Conchiterz.monkey_patch(String)
      @masculin = 'Bravo vous êtes inscrit. Joyeux anniversaire et bon vent!'
    end

    it "monkey_patch switch of the same way than without" do
      expect( @masculin.conchiterz(true, escape = ['joyeux', 'bon'])).to eq(Conchiterz.translate(@masculin, true))
      expect( @masculin.conchiterz(false)).to eq(Conchiterz.translate(@masculin, false))
    end
  end
end
