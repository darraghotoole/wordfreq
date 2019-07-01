lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "wordfreq/version"

Gem::Specification.new do |spec|
  spec.name          = "wordfreq"
  spec.version       = Wordfreq::VERSION
  spec.authors       = ["Darragh O'Toole"]
  spec.email         = ["darragh.otoole@gmail.com"]

  spec.summary       = %q{Count word frequency in wikipedia articles}
  spec.description   = %q{Count word frequency in wikipedia articles}
  spec.homepage      = "https://github.com/darraghotoole/wordfreq"
  spec.license       = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-rspec"
  spec.add_dependency "httparty"
end
