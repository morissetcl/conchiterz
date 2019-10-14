require 'config'
require 'swap_gender'

class Typography
  attr_reader :word, :escape, :result

  def initialize(word, escape, result)
    @word = word
    @escape = escape
    @result = result
  end

  def call
    analyze_string
  end

  private

  def analyze_string
    check_word_length
    if escape.include?(word)
      result.push(word)
    elsif Config::TRANSLATION.has_key?(word.downcase)
      SwapGender.new(@capitalized, @upcased, word, result).call
    else
      result.push(word)
    end
  end

  def check_word_length
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
end
