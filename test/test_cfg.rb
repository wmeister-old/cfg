require 'helper'
require 'tempfile'

class TestCfg < Test::Unit::TestCase
  context 'Cfg' do
    setup do
      @hash = {:foo => 'foo', :bar => 'bar'}
    end
    should "raise ArgumentError when initialized without any arguments" do
      assert_raise(ArgumentError) { Cfg.new }
    end
    should "raise ArgumentError when initialized with a single integer" do
      assert_raise(ArgumentError) { Cfg.new 1 }
    end
    should "raise Errno::ENOENT when initialized with a string that refers to a non-existent file" do
      assert_raise(Errno::ENOENT) { Cfg.new " =^_^= " }
    end
    should 'should initialize from a populated hash' do
      assert_instance_of Cfg, Cfg.new(@hash)
    end
    should 'should not initialize from a empty hash' do
      assert_raise(ArgumentError) { Cfg.new(Hash.new) }
    end
    should 'return the correct value for a given key when the corresponding method is called' do
      cfg = Cfg.new(@hash)
      assert_equal 'foo', cfg.foo
      assert_equal 'bar', cfg.bar
    end
    should 'initialize properly from a string referncing a yaml file' do
      f = Tempfile.new 'test.yaml'
      begin 
        f.write YAML::dump(@hash)     
        puts f.read
        assert_instance_of Cfg, Cfg.new(f.path)
      ensure
        f.close
        f.unlink
      end
    end
    should 'initialize properly from a string containing yaml' do
      # TODO
      flunk
      YAML
    end
    should 'work with symbols or strings as keys in the initialization hash' do
      # TODO
      flunk
    end
    should 'raise a NoMethodError when trying to call a method for which no key was provided in the initialization hash' do
      # TODO
      flunk
    end
  end
end
