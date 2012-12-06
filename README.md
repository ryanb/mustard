# Mustard

*Please, pass the mustard!*

An expectation library that adds "must" and "must_not" which can have matchers called on them. Comes with a default set of matchers, and additional matchers can be easily added. Works with RSpec, MiniTest, and Test::Unit. Requires Ruby 1.9 or greater.

This project is based on ideas presented in [this gist](https://gist.github.com/4221051). There I explain some of my issues with existing expectation interfaces.

## Installation

Add this line to your application's Gemfile and run the `bundle` command.

```ruby
gem 'mustard', group: :test
```


## Usage

Inside of a test or spec, call `must` or `must_not` on any object followed by a matcher. Some matchers have aliases.

```ruby
5.must.equal 5
5.must_not.eq 4

5.must.be_greater_than 4
5.must.be_gt 4

[].must.be :empty? # calls the method to see if it's true
record.must.be :valid?
5.must.be :between?, 6, 7
# raises Mustard::Failure: expected 5 to be between 6 and 7

-> { 5.bad_call }.must.raise_exception(NoMethodError)
```

See [the source code](https://github.com/ryanb/mustard/blob/master/lib/mustard.rb#L26) for a complete list of matchers and their behavior.


### Adding Matchers

Matchers are very easy to add. If a block is passed, it will be executed in the context of the subject.

```ruby
Mustard.matcher(:be_empty) { empty? }
[].must.be_empty?
[1].must.be_empty? # fail: expected [1] to be empty
```

Alternatively, you can pass a class to fully customize the behavior.

```ruby
class BetweenMatcher
  # Subject is always passed, any extra arguments will be added after
  def initialize(subject, min, max)
    @subject = subject
    @min = min
    @max = max
  end

  def match?
    @subject.between? @min, @max
  end

  def failure_message
    "expected #{@subject.inspect} to be between #{@min.inspect} and #{@max.inspect}."
  end

  def negative_failure_message
    "expected #{@subject.inspect} to not be between #{@min.inspect} and #{@max.inspect}."
  end
end

Mustard.matcher(:be_between, BetweenMatcher)
5.must.be_between(5, 7)
```


### Disabling Other Matchers

**For RSpec,** add this line to your `spec_helper.rb` if you want to disable other matchers.

```ruby
config.expect_with Mustard
```

**For MiniTest::Spec,** add this line to your `test_helper.rb` if you want to disable existing matchers.

```ruby
ENV["MT_NO_EXPECTATIONS"] = "true"
```


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Make changes and ensure they pass with `rspec .`
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create new Pull Request
