require 'singleton'

class Router
  include Singleton

  attr_reader :routes

  def self.draw(&block)
    Router.instance.instance_exec(&block)
  end

  def initialize
    @routes = {}
  end

  def get(path, &block)
    if block
      @routes[path] = block
    elsif path.include? '/'
      controller, action = path.split('/')
      controller_klass_name = "#{controller.capitalize}Controller"
      controller_klass = Object.const_get(controller_klass_name)

      @routes[path.prepend('/')] = lambda { |env|
        controller_klass.new(env).send(action.to_sym)
      }
    end
  end

  def build_response(env)
    path = env['REQUEST_PATH']
    handler = @routes[path] || -> { "no route found for #{path}" }
    handler.call(env)
  end
end
