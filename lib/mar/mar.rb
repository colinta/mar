class Class
  attr_accessor :mar_decorators

  def mar_decorators
    @mar_decorators ||= []
  end

  def clear_mar_decorators!
    @mar_decorators = []
  end

  def _(decorator)
    mar_decorators << decorator
  end

  def method_added(name)
    super
    decorators = mar_decorators
    clear_mar_decorators!
    if decorators.length > 0
      new_name = "marrrrrrrr_#{name}"
      alias_method new_name, name
      define_method(name) { |*args|
        decorator = decorators[0]
        here = lambda{ |*decorator_args, &blk|
          self.send(new_name, *decorator_args, &blk)
        }
        decorator.call(*args, &here)
      }
    end
  end

end
