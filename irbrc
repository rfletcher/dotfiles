require "rubygems"

# Wirble: colorization, history, completion, more!
# http://pablotron.org/software/wirble/README
begin
  require 'wirble'

  # init wirble
  Wirble::Colorize.colors = {
    :class => :light_purple,

    :open_string => :light_green,
    :close_string => :light_green,
    :string => :light_green,

    :number => :light_red,
    :symbol => :light_red,
    :keyword => :light_red
  }

  Wirble.init(
    :init_colors => true
  )
rescue LoadError => err
  $stderr.puts "Couldn't load Wirble: #{err}"
end

# add some helpful debugging methods
class Object
  # return only the methods not present on basic objects
  def interesting_methods
    (self.methods - Object.instance_methods).sort
  end
end
