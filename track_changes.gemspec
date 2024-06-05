require_relative 'lib/track_changes/version'

Gem::Specification.new do |s|
  s.name        = 'log-paper-trail-changes'
  s.version     = TrackChanges::VERSION
  s.date        = '2024-06-05'
  s.summary     = "Log changes in Papertrail models"
  s.description = "A gem that logs the changes made by PaperTrail in ActiveRecord models"
  s.authors     = ["Brandyn Britton"]
  s.email       = 'brandynbb96@gmail.com'
  s.files       = Dir['lib/**/*.rb']
  s.homepage    =
    'http://example.com/track_changes'
  s.license       = 'MIT'
  s.add_runtime_dependency 'paper_trail', '~> 11.0'
  s.add_runtime_dependency 'ruby', '~> 3.0.6'
  s.add_development_dependency 'rspec', '~> 3.0'
  s.add_development_dependency 'pry', '~> 0.14.0'
end