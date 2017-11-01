require 'strscan'

module Conchiterz
  class Feminize
    def self.translate(string)
      return if string.nil?
      result = []
      a_words = string.split
      a_words.each do |word|
        if TRANSLATION.has_value?(word.downcase)
          a = TRANSLATION.key(word.downcase)
          capitalized = (word == word.capitalize)
          capitalized ? result.push(a.capitalize) : result.push(a)
        elsif TRANSLATION.has_key?(word.downcase)
          b = TRANSLATION.fetch(word.downcase)
          capitalized = (word == word.capitalize)
          capitalized ? result.push(b.capitalize) : result.push(b)
        else
          result.push(word)
        end
      end
      result.join(' ')
    end

    TRANSLATION =
      {
        'beau' => 'belle',
        'joyeux' => 'joyeuse',
        'il' => 'elle',
        'ils' => 'elles',
        'présent' => 'presente',
        'nouveau' => 'nouvelle',
        'inscrit' => 'inscrite',
        'animateur' => 'animatrice',
        'joueur' => 'joueuse'
      }
  end
end
