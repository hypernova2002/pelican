require 'test/unit'
require 'bundler'
Bundler.require

ROOT = File.dirname(File.dirname(File.expand_path(__FILE__)))

require File.join(ROOT, 'lib', 'pelican')

Pelican.setup(
  'pelican_test:state',
  host: 'localhost',
  port: 6379,
  db: 1)
