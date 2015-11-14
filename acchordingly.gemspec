# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "acchordingly"
  spec.version       = '0.1'
  spec.authors       = ["Chuck Harris"]
  spec.email         = ["chuckjharris@yahoo.com"]
  spec.summary       = %q{Ruby application for parsing and rendering ChordPro files to PDF}
  spec.description   = %q{Ruby application for parsing and rendering ChordPro files to PDF}
  spec.homepage      = "https://github.com/chuck-harris/acchordingly"
  spec.license       = "MIT"

  spec.files         = ['lib/acchordingly.rb']
  spec.executables   = ['bin/acchordingly']
  spec.test_files    = ['tests/test_acchordingly.rb']
  spec.require_paths = ["lib"]
end
