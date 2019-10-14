require 'yaml'
require 'config'
require 'handle_peculiarity'
require 'typography'

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
    a_words = string.scan(Config::REGEXP)
    a_words.each { |word| Typography.new(word, escape, result).call }
    HandlePeculiarity.new(@word, result).call
    result.join(' ')
  end

  def monkey_patch(str)
    str.send(:include, Conchiterz::StringMethods)
  end
end

if defined?(Rails)
  Conchiterz.monkey_patch(String)
end
