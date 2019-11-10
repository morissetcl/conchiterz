require 'config'

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
    if escape.map(&:downcase).include?(word.downcase)
      result.push(word)
    elsif Config::TRANSLATION.has_key?(word.downcase)
      get_value(word, @capitalized, @upcased, result)
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

  def get_value(word, capitalized, upcased, result)
    value = Config::TRANSLATION.fetch(word.downcase)
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
    result
  end
end
