module Config
  SPECIAL_CHARACTER = ["'","-"]
  PUNCTUATION = [[';',':','!','?'],['.',',','...']]
  TRANSLATION = YAML.load_file('lib/words.yaml')
  REGEXP = /[[:alpha:][:digit:]]+|[[:punct:]]+/
end
