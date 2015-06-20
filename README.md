# ResultPicker
Result picker was designed to simply yield return value before the block ends
My own use case was returning model built inside transaction, which could be rolled back
because it was invalid. Normally, solution is

```ruby
  x = nil
  something do
    stuff
    x = value
    more_stuff
  end
  x
```
which is ugly. The better idea is to wrap this stuff inside one of your methods
e.g. `synchronize`, `transaction`, and this class allows you to DRY

Usage:

```ruby
  ResultPicker.pick! do |result_picker|
    something do
      stuff
      result_picker.call value
      more_stuff
    end
  end
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'result_picker'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install result_picker

## Usage


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/result_picker. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.

