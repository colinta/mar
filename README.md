MAR
===

Inspired by [this blog post][ruby-decorators], I started looking into what it
might actually take to implement it.  Turns out, it can be done in just one
method, and it relies exclusively on Ruby Procs.

Examble
=======

```ruby
require 'mar'

def decorator(*options)
  lambda { |*args, &blk|
    blk.call(*args.map{ |arg| "MAR #{arg}!" })
  }
end

class Foo
  _ decorator('foo')
  def foo(one_arg)
    one_arg + ' --from foo, with love'
  end

  def bar
    'I get no respect, I tell ya\', no respect.'
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
end
```

[ruby-decorators]: http://colinta.com/thoughts/a_modest_proposal.html
