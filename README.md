MAR
===

Inspired by [this blog post][ruby-decorators], I started looking into what it
might actually take to implement it.  Turns out, it can be done with just a few
methods tacked onto `Class`.  It relies exclusively on Ruby Procs.

Example
=======

```ruby
require 'mar'

# a decorator function *returns* a lambda.  methods aren't first-class in Ruby,
# so this is just how it's got to be.  On the other hand, it makes it very easy
# to accept options and use those in the method decorator!
def decorator(name)
  lambda { |original, arg, &blk|
    original.call("MAR #{arg}! --from #{name}", &blk)
  }
end

class Foo
  _ decorator('foo')  # this gets passed in as an "option" to decorator()
  def foo(one_arg)  # this get called via blk.call, which manipulates one_arg before calling the original method
    one_arg + ', with love'
  end

  def bar  # this doesn't get changed at all, but let's make sure of that...
    'I get no respect, I tell ya\', no respect.'
  end

  _ decorator('baz')  # this time, let's accept a block!
  def baz(one_arg)
    yield
    one_arg
  end

end

describe "Mar" do
  before do
    @foo = Foo.new
  end

  it 'should decorate Foo#foo' do
    @foo.foo('is great').should == 'MAR is great! --from foo, with love'
  end

  it 'should NOT decorate Foo#bar' do
    @foo.bar.should == 'I get no respect, I tell ya\', no respect.'
  end

  it 'should decorate Foo#baz and accept a block' do
    two = 1
    nifty = @foo.baz('is nifty') {
      two = 2
    }
    nifty.should == 'MAR is nifty! --from baz'
    two.should == 2
  end
end
```

[ruby-decorators]: http://colinta.com/thoughts/a_modest_proposal.html
