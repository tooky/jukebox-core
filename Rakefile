require "bundler/gem_tasks"

desc "Run unit tests"
task :specs do
  sh "rspec spec"
end

desc "Run cukes"
task :cukes do
  sh "cucumber"
end

task :default => [:specs, :cukes]
