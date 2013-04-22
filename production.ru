#\ -s puma
# encoding: UTF-8

require 'bundler'
Bundler.setup :production

require 'rack/rewrite'
require 'rack/contrib/try_static'
require 'rack/contrib/not_found'
require 'rack/robotz'

use Rack::Rewrite do
  r307 '/jrubyconf',  '/tags/jrubyconf'
  r307 '/hackdays',   '/tags/hackdays'
end
use Rack::Robotz, "User-Agent" => "*", "Disallow" => "/"
use Rack::TryStatic, :root => "build", :urls => %w[/], :try => ['.html', 'index.html', '/index.html']
run Rack::NotFound.new('./build/404.html')
