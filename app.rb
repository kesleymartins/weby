require 'erb'

class App
  def call(env)
    headers = {
      'Content-Type' => 'text/html'
    }

    title = 'Ruby on Rails'
    erb = ERB.new(html_template)
    response_html = erb.result(binding)

    [200, headers, [response_html]]
  end

  def html_template
    File.read('views/index.html.erb')
  end
end
