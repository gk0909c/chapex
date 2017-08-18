require 'bundler/gem_tasks'
require 'rake/testtask'
require 'rake/clean'

PARSER_FILE = 'lib/chapex/parser/apex.rb'.freeze

Rake::TestTask.new(:test) do |t|
  t.libs << 'test'
  t.test_files = FileList['test/**/*_test.rb']
end

Rake::TestTask.new(:e2e) do |t|
  t.libs << 'test'
  t.libs << 'e2e'
  t.test_files = FileList['e2e/**/*_test.rb']
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

task :test => [:generate]
task :e2e => [:generate]
task :all_test => [:test, :e2e]
task :default => :test
