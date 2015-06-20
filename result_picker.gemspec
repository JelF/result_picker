# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'result_picker'

Gem::Specification.new do |spec|
  spec.name          = "result_picker"
  spec.version       = ResultPicker::VERSION
  spec.authors       = ["Alexander Smirnov"]
  spec.email         = ["begdory4@gmail.com"]

  spec.summary       = %q{Result picker gem}
  spec.description   = %q{ResultPicker is a gem, allowing you to nicely yield results before code block finish. I wrote it to use in ActiveRecord transactions, when ActiveRecord::Rollback should be raised due to normal workflow to store objects generated inside transaction }
  spec.homepage      = 'https://github.com/JelF/result_picker'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features|doc)/}) }
  spec.require_paths = ["lib"]
  spec.license       = 'WTFPL'

  spec.add_development_dependency "bundler", "~> 1.10"
end
