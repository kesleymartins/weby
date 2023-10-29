require_relative '../router'

Router.draw do
  get('/') do |_env|
    'Root Page'
  end

  get('/articles') do
    'All articles'
  end

  get('/articles/1') do
    'one article'
  end
end
