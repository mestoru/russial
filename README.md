# Russial [![Gem Version](https://badge.fury.io/rb/russial.svg)](https://badge.fury.io/rb/russial) [![Build Status](https://travis-ci.org/mestoru/russial.svg?branch=master)](https://travis-ci.org/mestoru/russial)

An easy way to make word declension.

## Installation

Add this line to your application's Gemfile:
```ruby
gem "russial"
```

And then execute:
```
$ bundle
```

Or install it yourself as:

```
$ gem install russial
```

**Note:** for Rubies less than 2.3.0 we use `backport_dig` gem, but we strongly recommend you to upgrade your Ruby version to the last one.

## Usage

The Russial gem automatically works with any structures that you pass as dictionary. You can use it with plain Ruby or I18n/Rails.
Keys must be symbols.

### Plain Ruby

With plain Ruby it's looks like:

```ruby
ruby_dictionary = {
  ruby: {
    singular: {
      nominative: "рубин",
      genitive: "рубина",
      dative: "рубину",
      accusative: "рубин",
      instrumental: "рубином",
      prepositional: "рубине"
    },
    plural: {
      nominative: "рубины",
      genitive: "рубинов",
      dative: "рубинам",
      accusative: "рубины",
      instrumental: "рубинами",
      prepositional: "рубинах"
    }
  }   
}

word = Russial.new("ruby", dictionary: ruby_dictionary)

# Default state is singular
word.dative # "рубину"

# Save state
plural_word = word.plural

# Get cases of plural form
plural_word.genitive # "рубинов"
plural_word.instrumental # "рубинами"
```

### With I18n/Rails

With I18n/Rails support you need to add dictionary to locales. For example in file *`russial.yml`*:

```yaml
ru:
  russial:
    идти:
      future: пройдёт
      past:
        singular:
          male: прошёл
          female: прошла
        plural: прошли
      present: проходит
```

And then:

```ruby
# Rails wiil do this automatically
I18n.tap do |c|
  c.available_locales = [:ru]
  c.locale = :ru
  c.load_path = ["russial.yml"]
end

word = Russial.new("идти")

word.future # "пройдёт"
word.reset.past.singular.male # "прошёл"
word.reset.past.singular.female # "прошла"
```

### Substitutions

With this feature you can use the gem more advanced way. See example:

```ruby
flat_dictionary = {
  "многокомнатная квартира": { 
    nominative: "___комнатная квартира",
    genitive: "___комнатной квартиры",
    dative: "___комнатной квартире",
    accusative: "___комнатную квартиру",
    instrumental: "___комнатной квартирой",
    prepositional: "___комнатной квартире"
  }
}
substitutions = { "___" => "трёх" }

word = Russial.new("многокомнатная квартира", dictionary: flat_dictionary, substitutions: substitutions)

word.dative # "трёхкомнатной квартире"
word.instrumental # "трёхкомнатной квартирой"
```

## Settings

You can configure this gem. Add settings to initializers.

### Aliases

Add shorthands for any keys you want.

```ruby
Russial.configure do |c|
  c.aliases = {
    n: :nominative,
    g: :genitive,
    d: :dative,
    a: :accusative,
    i: :instrumental,
    p: :prepositional
  }.freeze
end
```

And then:

```ruby
word = Russial.new("ruby", dictionary: ruby_dictionary)

word.d # "рубину"
word.plural.g # "рубинов"
word.reset.plural.i # "рубинами"
```

### Scope for I18n

Change the root scope for I18n search.

```ruby
described_class.configure do |c|
  c.i18n_scope = "russial"
end
```

Default is `russial`.

## Contribute

Feel free to add pull requests and issues.

## License
  
See LICENSE for license information.
