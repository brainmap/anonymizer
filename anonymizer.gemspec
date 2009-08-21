# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{anonymizer}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Kristopher J. Kosmatka"]
  s.date = %q{2009-08-13}
  s.default_executable = %q{anonymize_data.rb}
  s.description = %q{Anonymizes a collection of files and/or directories for interrater reliabiliy analyses and the like.}
  s.email = %q{kk4@medicine.wisc.edu}
  s.executables = ["anonymize_data.rb"]
  s.extra_rdoc_files = ["bin/anonymize_data.rb", "lib/anonymizer.rb", "README.rdoc"]
  s.files = ["anonymizer.gemspec", "bin/anonymize_data.rb", "lib/anonymizer.rb", "Manifest", "Rakefile", "README.rdoc"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/kjkosmatka/anonymizer}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Anonymizer", "--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{anonymizer}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Anonymizes a collection of files and/or directories for interrater reliabiliy analyses and the like.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
