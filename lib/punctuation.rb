require 'config'

class Punctuation # mostly handle punctuation and special character like "-"
  attr_reader :result

  def initialize(result)
    @result = result
  end

  def call
    check_punctuation
    check_special_character
  end

  private

  def check_punctuation
    result.each_with_index do |val, index|
      if Config::PUNCTUATION.flatten.include?(val) # punctuation = [[';',':','!','?'],['.',',','...']]
        index = result.index(val)
        word = return_word_with_space_or_not(val, index)
        result[index].insert(0, word)
        result.delete(result[index-1])
      end
    end
  end

  def return_word_with_space_or_not(val, index)
    if Config::PUNCTUATION[0].include?(val)
      result[index-1] + ' '
    else
      result[index-1]
    end
  end

  def check_special_character
    result.each_with_index do |val, index|
      if Config::SPECIAL_CHARACTER.include?(val)
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
end
