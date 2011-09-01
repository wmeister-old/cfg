require 'yaml'

class Cfg
  def initialize(x)
    raise "First argument needs to be a string or a hash" unless [Hash, String].include? x.class
    if x.is_a? String
      x = YAML::load(File.read(x))
      raise "YAML file must contain a single hash" unless x.is_a? Hash
    end
    @store = {}
    x.each do |k,v|      
      @store[k.is_a?(Symbol) ? k : k.to_sym] = v
    end
  end

  def method_missing(m)
    if @store.has_key?(m); @store[m]
    else super(m); end
  end
end
