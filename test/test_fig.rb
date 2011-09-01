require 'helper'
require 'tempfile'

class TestFig < Test::Unit::TestCase
  context 'Fig' do
    setup do
      @hash = {:foo => 'foo', :bar => 'bar'}
    end
    should "raise ArgumentError when initialized without any arguments" do
      assert_raise(ArgumentError) { Fig.new }
    end
    should "raise ArgumentError when initialized with a single integer" do
      assert_raise(ArgumentError) { Fig.new 1 }
    end
    should "raise Errno::ENOENT when initialized with a string that refers to a non-existent file" do
      assert_raise(Errno::ENOENT) { Fig.new " =^_^= " }
    end
    should 'should initialize from a populated hash' do
      assert_instance_of Fig, Fig.new(@hash)
    end
    should 'should not initialize from a empty hash' do
      assert_raise(ArgumentError) { Fig.new(Hash.new) }
    end
    should 'return the correct value for a given key when the corresponding method is called' do
      cfg = Fig.new(@hash)
      assert_equal 'foo', cfg.foo
      assert_equal 'bar', cfg.bar
    end
    should 'initialize properly from a string referncing a yaml file' do
      f = Tempfile.new 'test.yaml'
      begin 
        f.write YAML::dump(@hash)     
        puts f.read
        assert_instance_of Fig, Fig.new(f.path)
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
