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
    @routes[path] = block
  end

  def build_response(env)
    path = env['REQUEST_PATH']
    handler = @routes[path] || -> { "no route found for #{path}" }
    handler.call(env)
  end
end
