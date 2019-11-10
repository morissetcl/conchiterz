require 'conchiterz'

describe Punctuation do
  it "with special character between two words" do
    typo = Punctuation.new(["Post", "-", "It"])
    expect(typo.call).to eql(["Post-It"])
  end

  context 'handle space with punctuation according to french rules' do
    it "no space before «. , ...»" do
      typo = Punctuation.new(["Bonjour", ",", "Clément", '.'])
      expect(typo.call).to eql(["Bonjour,", "Clément."])
    end

    it "space before « ; : ! ? »" do
      typo = Punctuation.new(["Bonjour", ":", "Clément", '!'])
      expect(typo.call).to eql(["Bonjour :", "Clément !"])
    end
  end
end
