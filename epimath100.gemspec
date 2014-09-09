require_relative "lib/epimath100/gem-version"

Gem::Specification.new do |s|
  s.name        = 'epimath100'
  s.version     = RubyHelper::VERSION
  s.date        = Time.now.getgm.to_s.split.first
  s.summary     = ""
  s.description = "EpiMath100, a ruby gem lib to use lines, functions, points, ..."
  s.authors     = [
  		  "poulet_a",
  		  "broggi_t",
		  "bauwen_j",
		  "caudou_j"
		  ]
  s.email       = "poulet_a@epitech.eu",
  s.files       = [
  		  "lib/epimath100.rb",
  		  "lib/epimath100/gem-version.rb",
		  "lib/epimath100/line.class.rb",
		  "lib/epimath100/matrix.class.rb",
		  "lib/epimath100/point.class.rb",
		  "lib/epimath100/function.class.rb",
		  "lib/epimath100/polynomial.class.rb",
		  "lib/epimath100/rational.class.rb",
		  "lib/epimath100/vector.class.rb",
		  "README.md",
		  "LICENSE",
		  "epimath100.gemspec",
		  "epimath100.man",
		  "test/"
		  ]
  s.homepage    = "https://github.com/Sophen/epimath100"
  s.license     = "GNU/GPLv3"

  s.add_runtime_dependency 'myerror', '~> 1.1.0', '>= 1.0.0'
end