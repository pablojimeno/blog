#\ -s puma
# encoding: UTF-8

require 'bundler'
Bundler.setup :production

require 'rack/contrib/try_static'
require 'rack/contrib/not_found'

use Rack::TryStatic, :root => "build", :urls => %w[/], :try => ['.html', 'index.html', '/index.html']
run Rack::NotFound.new('./build/404.html')
