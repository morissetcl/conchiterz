module Conchiterz
  extend self

  module StringMethods
    def conchiterz(switch)
      Conchiterz.translate(self, switch)
    end
  end

  def translate(string, switch, escape = [])
    return if string.nil?
    result = []
    a_words = string.scan(/[[:alpha:]]+|[.,!?';]+/)
    delete = a_words.index(escape.join(''))
    a_words.delete(escape.join(''))
    if switch == true
      a_words.each{ |word| analyze_string(word, result) }
      check_punctuation(result)
      check_special_character(result)
      p delete - 1
      result.insert(delete-2, escape.join(''))
      result.join(' ')
    else
      return string
    end
  end

  def monkey_patch(str)
    str.send(:include, Conchiterz::StringMethods)
  end

  private

  def analyze_string(word, result)
    check_word_length(word)
    if TRANSLATION.has_key?(word.downcase)
      get_value(@capitalized, @upcased, result, word)
    else
      result.push(word)
    end
  end

  def check_word_length(word)
    if word.length == 1
      @capitalized = (word == word.capitalize)
    else
      @capitalized = (word == word.capitalize)
      @upcased = (word == word.upcase)
    end
  end

  def get_value(capitalized, upcased, result, word)
    value = TRANSLATION.fetch(word.downcase)
    add_value_to_result(capitalized, upcased, value, result)
  end

  def add_value_to_result(capitalized, upcased, value, result)
    if check_sensitive(capitalized, upcased) == false
      result << value
    else
      capitalize_or_upcase(capitalized, upcased, value, result)
    end
  end

  def check_sensitive(capitalized, upcased)
    return if (capitalized == true || upcased == true)
    false
  end

  def capitalize_or_upcase(capitalized, upcased, value, result)
    result << value.capitalize if capitalized
    result << value.upcase if upcased
  end

  def check_punctuation(result)
    punctuation = [',','.','!',':',';']
    result.each_with_index do |val, index|
      if punctuation.include?(val)
        index = result.index(val)
        result[index].insert(0, result[index-1])
        result.delete(result[index-1])
      end
    end
  end

  def check_special_character(result)
    result.each_with_index do |val, index|
      if val == "'"
        index = result.index(val)
        word = [result[index-1], result[index], result[index+1]]
        delete_useless_value(word, index, result)
        result.insert(index-1, word.join(''))
      end
    end
  end

  def delete_useless_value(word, index, result)
    word.each do |a|
      index_to_delete = result.index(a)
      result.delete_at(index_to_delete)
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
      'le' => 'la',
      'chers' => 'chères',
      'cher' => 'chère',
      'bon' => 'bonne'
    }

end

if defined?(Rails)
  Conchiterz.monkey_patch(String)
end
