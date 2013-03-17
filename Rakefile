require 'bundler/setup'
# require 'heroku_san'
# 
# module HerokuSan::Deploy
#   class Eurucamp < Sinatra
#     def deploy
#       super
#       #@stage.rake('utils:update_sitemap')
#       #@stage.rake('utils:update_attendees')
#     end
#   end
# end
# 
# config_file = File.join(File.expand_path(File.dirname(__FILE__)), 'config', 'heroku.yml')
# HerokuSan.project = HerokuSan::Project.new(config_file, :deploy => HerokuSan::Deploy::Eurucamp)
# 
# load 'heroku_san/tasks.rb'

require 'nokogiri'
require 'open-uri'
require 'yaml'
require 'sitemap_generator'

namespace :utils do
  desc "Update sitemap"
  task :update_sitemap do
    SitemapGenerator::Sitemap.default_host = 'http://blog.eurucamp.org'
    SitemapGenerator::Sitemap.public_path = "source"
    SitemapGenerator::Sitemap.create do
      add '/',           :changefreq => 'hourly'
      add '/blog',       :changefreq => 'hourly', :priority => 0.9
      Dir["source/blog/*"].each do |blog_entry_file|
        post_link = blog_entry_file.gsub(/^source\/blog\/|\.html.markdown$/,"")
        post_link = post_link[0..10].gsub("-","/") + post_link[11,post_link.size]
        add post_link,   :changefreq => 'hourly', :priority => 0.9
      end
    end
    SitemapGenerator::Sitemap.ping_search_engines
  end
end
