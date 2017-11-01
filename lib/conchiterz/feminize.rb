module Conchiterz
  class Feminize
    def self.translate(string)
      return if string.nil?
      result = []
      a_words = string.scan(/[\w'-]+|\W+/).select {|x| x.match(/\S/)}
      a_words.each do |word|
        analyze_string(word, result)
      end
      result.each_cons(2) do |r, a|
        if a == ', '
          v = r.insert(-1, a.strip)
          result.delete(a)
        end
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
      add_value_to_result(capitalized, upcased, key, result)
    end

    def self.get_value(capitalized, upcased, result, word)
      value = TRANSLATION.fetch(word.downcase)
      add_value_to_result(capitalized, upcased, value, result)
    end

    def self.add_value_to_result(capitalized, upcased, type, result)
      if check_sensitive(capitalized, upcased) == false
        result << type
      else
        capitalize_or_upcase?(capitalized, upcased, type, result)
      end
    end

    def self.check_sensitive(capitalized, upcased)
      return unless (capitalized == false && upcased == false)
      false
    end

    def self.capitalize_or_upcase?(capitalized, upcased, type, result)
      result << type.capitalize if capitalized
      result << type.upcase if upcased
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
        'joueur' => 'joueuse',
        'pareil' => 'pareille',
        'pareils' => 'pareilles'
      }
  end
end
