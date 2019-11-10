require 'conchiterz'

describe Typography do # Typography.new(word, escaped_words, result)
  context 'with word not downcased' do
    it "with word capitalized" do
      typo = Typography.new('Joyeux', [], [])
      expect(typo.call).to eql(["Joyeuse"])
    end

    it 'with word upcased' do
      typo = Typography.new('JOYEUX', [], [])
      expect(typo.call).to eql(["JOYEUSE"])
    end
  end

  context 'without escaped words' do
    it 'return word feminized' do
      typo = Typography.new('joyeux', [], [])
      expect(typo.call).to eql(["joyeuse"])
    end
  end

  context 'with escaped words' do
    it 'does not change word if word is includes within escaping array' do
      typo = Typography.new('joyeux', ["joyeux"], [])
      expect(typo.call).to eql(["joyeux"])
    end

    it 'return word feminized' do
      typo = Typography.new('heureux', ["joyeux"], [])
      expect(typo.call).to eql(["heureuse"])
    end

    it 'does not change word if word is includes within escaping array even upcased' do
      typo = Typography.new('JOYEUX', ["joyeux"], [])
      expect(typo.call).to eql(["JOYEUX"])
    end
  end

  it 'add the feminized word to result array' do
    typo = Typography.new('JOYEUX', [], ['Bonjour', 'la'])
    expect(typo.call).to eql(["Bonjour", "la", "JOYEUSE"])
  end
end
