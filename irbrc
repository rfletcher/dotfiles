require "rubygems"

# add some helpful debugging methods
class Object
  # return only the methods not present on basic objects
  def interesting_methods
    (self.methods - Object.instance_methods).sort
  end
end

# pretty print an object as JSON
def pj( o )
  puts JSON.pretty_generate( JSON.parse( o.to_json ) )
end
