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
          upcased = (word == word.upcase)
          if check_sensitive(capitalized, upcased) == false
            result << a
          else
            result << a.capitalize if capitalized
            result << a.upcase if upcased
          end
        elsif TRANSLATION.has_key?(word.downcase)
          b = TRANSLATION.fetch(word.downcase)
          capitalized = (word == word.capitalize)
          upcased = (word == word.upcase)
          if check_sensitive(capitalized, upcased) == false
            result << b
          else
            result << b.capitalize if capitalized
            result << b.upcase if upcased
          end
        else
          result.push(word)
        end
      end
      result.join(' ')
    end

    private
    
    def self.check_sensitive(capitalized, upcased)
      if (capitalized == false && upcased == false)
        false
      end
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
