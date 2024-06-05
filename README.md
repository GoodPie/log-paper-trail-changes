Sure, here's a basic README template for your `log-paper-trail-changes` gem:

```markdown
# Log PaperTrail Changes

This is a Ruby gem that logs the changes made by PaperTrail in ActiveRecord models.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'log-paper-trail-changes'
```

And then execute:

```bash
$ bundle install
```

Or install it yourself as:

```bash
$ gem install log-paper-trail-changes
```

## Usage

First, require the gem in your Ruby code:

```ruby
require 'log-paper-trail-changes'
```

Then, create an instance of the `TrackChanges` class and call its methods:

```ruby
# Replace these with your actual model class, IDs, and dates
model_class = YourModelClass
ids = [1, 2, 3]
start_date = Date.new(2024, 1, 1)
end_date = Date.new(2024, 12, 31)

track_changes = TrackChanges.new(model_class, ids, start_date, end_date)
result = track_changes.call

# The result will be a hash with the tracked changes
puts result
```

Please note that this gem is designed to work with models that use the `paper_trail` gem for versioning. If your model doesn't use `paper_trail`, this gem may not work as expected.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/goodpie/log-paper-trail-changes.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
```

