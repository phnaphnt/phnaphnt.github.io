# coding: utf-8

Gem::Specification.new do |spec|
  spec.name          = "jekyll-clean-dark"
  spec.version       = "0.1.3"
  spec.authors       = ["Harris Pham"]
  spec.email         = ["phnanh.harris@gmail.com"]

  spec.summary       = %q{A blog I written about whatever I like.}
  spec.description   = "A blog I written about whatever I like, like my hobbies, my thoughts, and I will write the most about wine, technical skill and motorcycle."
  spec.homepage      = "https://github.com/phnaphnt/phnaphnt.github.io"
  spec.license       = "MIT"

  spec.metadata["plugin_type"] = "theme"

  spec.files         = `git ls-files -z`.split("\x0").select do |f|
    f.match(%r{^(assets|_(includes|layouts|sass|posts|tag)/|(LICENSE|README)((\.(txt|md|markdown|xml)|$)))}i)
  end

  spec.add_development_dependency "jekyll", "~> 3.5"
  spec.add_development_dependency "bundler", "~> 1.12"
end
