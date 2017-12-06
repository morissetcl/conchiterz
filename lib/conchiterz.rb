module Conchiterz
  def self.translate(string, boolean)
    return if string.nil?
    result = []
    a_words = string.scan(/[[:alpha:]]+|[.,!?']+/)
    if boolean == true
      a_words.each do |word|
        analyze_string(word, result)
      end
      check_punctuation(result)
      check_special_character(result)
      result.join(' ')
    else
      return string
    end
  end

  private

  def self.analyze_string(word, result)
    check_word_length(word)
    if TRANSLATION.has_key?(word.downcase)
      get_value(@capitalized, @upcased, result, word)
    else
      result.push(word)
    end
  end

  def self.check_word_length(word)
    if word.length == 1
      @capitalized = (word == word.capitalize)
    else
      @capitalized = (word == word.capitalize)
      @upcased = (word == word.upcase)
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

  def self.check_punctuation(result)
    result.each_with_index do |val, index|
      if val == ',' || val == '.'
        a = result.index(val)
        result[a].insert(0, result[a-1])
        result.delete(result[a-1])
      end
    end
  end

  def self.check_special_character(result)
     result.each_with_index do |val, index|
       if val == "'"
         a = result.index(val)
         b = result[a].insert(0, result[a-1])
         index1 = result.index(b)
         c = result[index1].insert(-1, result[index1+1])
         d = result[result.index(c)+1]
         v = result[result.index(c)-1]
         result.delete_at(result.index(v))
         result.delete_at(result.index(c)+1)
       end
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
      'joueur' => 'joueuse',
      'pareil' => 'pareille',
      'pareils' => 'pareilles',
      'monsieur' => 'madame',
      'm' => 'mme',
      'le' => 'la'
    }

end
