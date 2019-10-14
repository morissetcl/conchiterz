require 'config'

class SwapGender
  attr_reader :word, :capitalized, :upcased, :result

  def initialize(capitalized, upcased, word, result)
    @word = word
    @capitalized = capitalized
    @upcased = upcased
    @result = result
  end

  def call
    get_value
  end

  private

  def get_value
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
  end
end
