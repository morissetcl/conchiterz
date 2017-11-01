module Conchiterz
  class Feminize
    def self.translate(string)
      return if string.nil?
      result = []
      a_words = string.split
      a_words.each do |word|
        analyze_string(word, result)
      end
      result.join(' ')
    end

    private

    def self.analyze_string(word, result)
      capitalized = (word == word.capitalize)
      upcased = (word == word.upcase)
      if TRANSLATION.has_value?(word.downcase)
        get_key(capitalized, upcased, result, word)
      elsif TRANSLATION.has_key?(word.downcase)
        get_value(capitalized, upcased, result, word)
      else
        result.push(word)
      end
    end

    def self.get_key(capitalized, upcased, result, word)
      key = TRANSLATION.key(word.downcase)
      if check_sensitive(capitalized, upcased) == false
        result << key
      else
        result << key.capitalize if capitalized
        result << key.upcase if upcased
      end
    end


    def self.get_value(capitalized, upcased, result, word)
      value = TRANSLATION.fetch(word.downcase)
      if check_sensitive(capitalized, upcased) == false
        result << value
      else
        result << value.capitalize if capitalized
        result << value.upcase if upcased
      end
    end

    def self.check_sensitive(capitalized, upcased)
      return unless (capitalized == false && upcased == false)
      false
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
