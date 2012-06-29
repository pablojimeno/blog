jrubyconf.eu Website README
===========================

In this repository you'll find the website for JRubyConf EU.

Install
-------

Provided you have RVM installed, installation should require **4 Steps**:

    rvm 1.9.3
    rvm gemset create middleman
    gem install bundler
    bundle install

Running
-------

### Building static pages

You can build the site into a `build`-directory:

    bundle exec middleman build

The `build` directory will contain the generated HTML, CSS and JavaScript and
the contents can be uploaded to any standard web server.

### Setting up host names when testing rewriting

You can use well known `lvh.me` domain if you don't like to mess around with local DNS config:

    `HOST_EURUCAMP=lvh.me HOST_JRUBYCONF=jruby.lvh.me bundle exec rackup`

### With Pow

Download and install [POW](http://pow.cx/):

    curl get.pow.cx | sh

Then:

    cd ~/.pow
    ln -s /path/to/jrubyconf.eu jrubyconf

You will see the generated HTML & CSS by navigating to <http://eurucamp.dev/>.

### With the built-in server

To run:

    bundle exec middleman server

You will see the generated HTML & CSS by navigating to <http://localhost:4567/>.

Deployment
----------

### Staging

* <http://dev.jrubyconf.eu/>
* `bundle exec rake staging deploy`

### Production

* <http://jrubyconf.eu/>
* `bundle exec rake production deploy`
