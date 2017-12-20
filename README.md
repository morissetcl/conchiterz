[![Gem Version](https://badge.fury.io/rb/conchiterz.svg)](https://badge.fury.io/rb/conchiterz)
# Conchiterz

A simply gem to feminize french word/sentence.

* Keep intact upcase, downcase and capitalize letters.
* Allows you to escape some words if you does not want feminize them.
* Handle and return punctuation according the [french rules](http://www.la-ponctuation.com/). (.;:!...,?)
* Keep intact word with accent. (éèêâàûôî)
* Handle some special character. ('-%)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'conchiterz'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install conchiterz

## Get started
`Conchiterz.translate(string, boolean, escape = [])` feminize a french string if boolean is evaluates to true.

Use on your CLI :
```ruby
[1] pry(main)> require 'conchiterz'
=> true
[2] pry(main)> Conchiterz.translate('Vous vous êtes inscrit avec succès.', true)
=> "Vous vous êtes inscrite avec succès."
```

If you give feminine string whatever the boolean value, the same string will be returned.

### Escaping words

Sometimes in french you should have the need to not feminize some word in function of the context of your sentence.

Take the following code and sentence:

```ruby
Conchiterz.translate('Nous vous souhaitons un joyeux réveillon, soyez heureux en 2018'
, true)
```

We don't want the following result:

```ruby
'Nous vous souhaitons une joyeuse réveillon, soyez heureuse en 2018'
```
Because 'un joyeux réveillon' is invariable in french.

In this way let's introduce the escape option.

Just add an array of which words you not wanted to feminize, check the following code:

```ruby
[1] pry(main)> require 'conchiterz'
=> true
[2] pry(main)> Conchiterz.translate('Nous vous souhaitons un joyeux réveillon, soyez heureux en 2018'
, true, ['un', 'joyeux'])
=> 'Nous vous souhaitons un joyeux réveillon, soyez heureuse en 2018'
```
Et voila! Easy to feminize your sentence still understandable by french speaker.

## Rails

It adds String#conchiterz(boolean, escape = [])

If you just want to feminize a sentence add in your view,

```ruby
# app/views/pratiquants/show.html.erb

<%= 'Vous êtes bien inscrit à notre newsletter.'.conchiterz(@pratiquant.female?) %>
```
Will return

```ruby
"Vous êtes bien inscrite à notre newsletter."
```
if your pratiquant is a female.

### Escaping words

You wanted to escape some words? Just add these words inside an array and pass it as argument, as follow..

```ruby
# app/views/pratiquants/show.html.erb

<%= 'Nous vous souhaitons un joyeux réveillon et soyez heureux en 2018'.conchiterz(@pratiquant.female?,['un', 'joyeux']) %>
```
Will return

```ruby
'Nous vous souhaitons un joyeux réveillon et soyez heureuse en 2018'
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/morissetcl/conchiterz. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
