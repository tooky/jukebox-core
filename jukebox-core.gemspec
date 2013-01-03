# -*- encoding: utf-8 -*-
Gem::Specification.new do |gem|
  gem.name          = "jukebox-core"
  gem.version       = "0.0.1"
  gem.authors       = ["Steve Tooke", "Matt Wynne"]
  gem.email         = ["steve@heavi.es", "matt@matwynne.net"]
  gem.description   = %q{We built this for a screencast series about Hexagonal Rails.}  # Add detail
  gem.summary       = %q{The core domain model for the weddding jukebox app.}  # Summarize the detail
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.test_files    = gem.files.grep(%r{^(spec|features)/})
  gem.require_paths = ["lib"]

  [ 'cucumber', 'rspec', 'guard-cucumber', 'guard-rspec', 'rb-fsevent',
    'terminal-notifier-guard', 'vcr', 'webmock' ].each do |name|
    gem.add_development_dependency name
  end

  [ 'virtus', 'rest-client' ].each do |name|
    gem.add_runtime_dependency name
  end
end
