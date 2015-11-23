
begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new :spec

  task :default => :spec
rescue LoadError
end

begin
  require 'cucumber'
  require 'cucumber/rake/task'

  Cucumber::Rake::Task.new( :features ) do |t|
    t.cucumber_opts = "features --format pretty"
  end
end