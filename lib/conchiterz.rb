require 'yaml'

module Conchiterz
  extend self
  attr_reader :result

  module StringMethods
    def conchiterz(switch, escape = [])
      Conchiterz.translate(self, switch, escape)
    end
  end

  def translate(string, switch, escape = [])
    return if string.nil?
    return string unless switch

    @result = []
    a_words = string.scan(REGEXP)
    a_words.each{ |word| analyze_string(word, escape) }
    check_special_format
    result.join(' ')
  end

  def check_special_format
    check_punctuation
    check_special_character
  end

  def monkey_patch(str)
    str.send(:include, Conchiterz::StringMethods)
  end

  private

  def analyze_string(word, escape)
    @word = word
    check_word_length(word)
    if escape.include?(word)
      result.push(word)
    elsif TRANSLATION.has_key?(word.downcase)
      get_value(@capitalized, @upcased, word)
    else
      result.push(word)
    end
  end

  def check_word_length(word)
    if word.length == 1
      @capitalized = capitalized? word
    else
      @capitalized, @upcased = capitalized?(word), upcased?(word)
    end
  end

  def capitalized? word
    word == word.capitalize
  end

  def upcased? word
    word == word.upcase
  end

  def get_value(capitalized, upcased, word)
    value = TRANSLATION.fetch(word.downcase)
    add_value_to_result(capitalized, upcased, value)
  end

  def add_value_to_result(capitalized, upcased, value)
    if check_sensitive(capitalized, upcased) == false
      result << value
    else
      capitalize_or_upcase(capitalized, upcased, value)
    end
  end

  def check_sensitive(capitalized, upcased)
    return if (capitalized || upcased)
    false
  end

  def capitalize_or_upcase(capitalized, upcased, value)
    result << value.capitalize if capitalized
    result << value.upcase if upcased
  end

  def check_punctuation
    result.each_with_index do |val, index|
      if PUNCTUATION.flatten.include?(val)
        index = result.index(val)
        word = return_word_with_space_or_not(val, index)
        result[index].insert(0, word)
        result.delete(result[index-1])
      end
    end
  end

  def return_word_with_space_or_not(val, index)
    if PUNCTUATION[0].include?(val)
      result[index-1] + ' '
    else
      result[index-1]
    end
  end

  def check_special_character
    result.each_with_index do |val, index|
      if SPECIAL_CHARACTER.include?(val)
        index = result.index(val)
        word = [result[index-1], result[index], result[index+1]]
        delete_useless_value(word, index)
        result.insert(index-1, word.join(''))
      end
    end
  end

  def delete_useless_value(word, index)
    word.each do |a|
      index_to_delete = result.index(a)
      result.delete_at(index_to_delete)
    end
  end

  SPECIAL_CHARACTER = ["'","-"]
  PUNCTUATION = [[';',':','!','?'],['.',',','...']]
  TRANSLATION = YAML.load_file('lib/words.yaml')
  REGEXP = /[[:alpha:][:digit:]]+|[[:punct:]]+/
end

if defined?(Rails)
  Conchiterz.monkey_patch(String)
end
