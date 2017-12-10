# Conchiterz

A simply gem to feminize french word and french sentence.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'conchiterz'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install conchiterz

## Usage
`Conchiterz.translate(string, boolean)` feminize a french string if boolean is evaluates to true.

Use on your CLI :
```ruby
[1] pry(main)> require 'conchiterz'
=> true
[2] pry(main)> Conchiterz.translate('Vous vous êtes inscrit avec succès.', true)
=> "Vous vous êtes inscrite avec succès."
```

If you give feminine string whatever the boolean value, the same string will be returned.

## Rails

It adds String#conchiterz(boolean)

So in your view,

```ruby
# app/views/pratiquants/show.html.erb

<%= "Vous êtes bien inscrit à notre newsletter.".conchiterz(@pratiquant.female?) %>
```
Will return
```
"Vous êtes bien inscrite à notre newsletter."
```
if your pratiquant is a female.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/morissetcl/conchiterz. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
