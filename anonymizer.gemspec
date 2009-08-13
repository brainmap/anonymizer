# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{anonymizer}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Kristopher J. Kosmatka"]
  s.date = %q{2009-08-12}
  s.default_executable = %q{anonymize_data.rb}
  s.description = %q{Anonymizes a collection of files and/or directories for interrater reliabiliy analyses and the like.}
  s.email = %q{kk4@medicine.wisc.edu}
  s.executables = ["anonymize_data.rb"]
  s.extra_rdoc_files = ["bin/anonymize_data.rb", "lib/anonymizer.rb", "README.rdoc"]
  s.files = ["bin/anonymize_data.rb", "lib/anonymizer.rb", "Rakefile", "README.rdoc", "test/input/aaa/aaa.txt", "test/input/bbb/bbb.txt", "test/input/ccc/ccc.txt", "test/input/ddd/ddd.txt", "test/input/eee/eee.txt", "test/input/fff.txt", "test/out_1/0/ddd.txt", "test/out_1/1/aaa.txt", "test/out_1/2/ccc.txt", "test/out_1/3.txt", "test/out_1/4/eee.txt", "test/out_1/5/bbb.txt", "test/out_1/keymap.yml", "test/out_2/0/bbb.txt", "test/out_2/1/ccc.txt", "test/out_2/2.txt", "test/out_2/3/ddd.txt", "test/out_2/4/aaa.txt", "test/out_2/5/eee.txt", "test/out_2/keymap.yml", "test/out_3/0/aaa.txt", "test/out_3/1/ccc.txt", "test/out_3/2/ddd.txt", "test/out_3/3/eee.txt", "test/out_3/4.txt", "test/out_3/5/bbb.txt", "test/out_3/keymap.yml", "Manifest", "anonymizer.gemspec"]
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
