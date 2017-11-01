require 'strscan'

module Conchiterz
  class Feminize
    def self.translate(string)
      return if string.nil?
      result = []
      a_words = string.split
      a_words.each do |word|
        if TRANSLATION.has_value?(word)
          a = TRANSLATION.key(word)
          result.push(a)
        elsif TRANSLATION.has_key?(word)
          b = TRANSLATION.fetch(word)
          result.push(b)
        else
          puts 'nothing'
          result.push(word)
        end
      end
      result.join(' ')
    end

    TRANSLATION =
      {
        'beau' => 'belle',
        'joyeux' => 'joyeuse'
      }
  end
end
