require 'yaml'

module Conchiterz
  extend self

  module StringMethods
    def conchiterz(switch, escape = [])
      Conchiterz.translate(self, switch, escape)
    end
  end

  def translate(string, switch, escape = [])
    return if string.nil?
    result = []
    a_words = string.scan(/[[:alpha:][:digit:]]+|[.,!?';:]+/)
    if switch == true
      a_words.each{ |word| analyze_string(word, result, escape) }
      check_punctuation(result)
      check_special_character(result)
      result.join(' ')
    else
      return string
    end
  end

  def monkey_patch(str)
    str.send(:include, Conchiterz::StringMethods)
  end

  private

  def analyze_string(word, result, escape)
    check_word_length(word)
    if TRANSLATION.has_key?(word.downcase) && escape.include?(word)
      result.push(word)
    elsif TRANSLATION.has_key?(word.downcase)
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
    result.each_with_index do |val, index|
      if PUNCTUATION.flatten.include?(val)
        index = result.index(val)
        if PUNCTUATION[0].include?(val)
          word = result[index-1] + ' '
        else
          word = result[index-1]
        end
        result[index].insert(0, word)
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

  PUNCTUATION = [[';',':','!','?'],['.',',','...']]
  TRANSLATION = YAML.load_file('lib/words.yaml')
end

if defined?(Rails)
  Conchiterz.monkey_patch(String)
end
