require 'bundler/gem_tasks'
require 'rake/testtask'
require 'rake/clean'

PARSER_FILE = 'lib/chapex/parser/apex.rb'.freeze

Rake::TestTask.new(:test) do |t|
  t.libs << 'test'
  t.libs << 'lib'
  t.test_files = FileList['test/**/*_test.rb']
end

CLEAN.include([PARSER_FILE])

desc 'generate apex parser with racc'
task :generate => [:clean, PARSER_FILE]

rule '.rb' => '.y' do |t|
  puts 'do rule for racc'
  opts = [
    '--superclass=Chapex::Parser::Base',
    t.source,
    '-o', t.name
  ]

  sh 'racc', *opts
end

task :default => :test
