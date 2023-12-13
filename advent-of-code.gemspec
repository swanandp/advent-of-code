
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "advent_of_code"

Gem::Specification.new do |spec|
  spec.name          = "advent-of-code"
  spec.version       = AdventOfCode::VERSION
  spec.authors       = ["Swanand Pagnis"]
  spec.email         = ["swanand.pagnis@gmail.com"]

  spec.summary       = %q{Solutions for advent of code problems}
  spec.description   = %q{My attempts at solving advent of code problems, and climbing up the leaderboard. http://adventofcode.com/2017/}
  spec.homepage      = "https://github.com/swanandp/advent-of-code"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "scanf"
  spec.add_development_dependency "sorted_set"
  spec.add_development_dependency "awesome_print"
  spec.add_development_dependency "terminal-table"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "parslet"
  spec.add_development_dependency "text"
end
