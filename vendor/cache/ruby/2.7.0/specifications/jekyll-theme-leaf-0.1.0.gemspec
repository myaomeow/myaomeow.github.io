# -*- encoding: utf-8 -*-
# stub: jekyll-theme-leaf 0.1.0 ruby lib

Gem::Specification.new do |s|
  s.name = "jekyll-theme-leaf".freeze
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Supun Kavinda".freeze]
  s.date = "2020-02-25"
  s.email = ["supunkavinda1125@gmail.com".freeze]
  s.homepage = "https://github.com/SupunKavinda/jekyll-theme-leaf".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.1.2".freeze
  s.summary = "Minimal yet beautiful Jekyll theme for dark background lovers.".freeze

  s.installed_by_version = "3.1.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<jekyll>.freeze, ["~> 3.8"])
    s.add_runtime_dependency(%q<jekyll-feed>.freeze, ["~> 0.9"])
    s.add_runtime_dependency(%q<jekyll-seo-tag>.freeze, ["~> 2.1"])
    s.add_development_dependency(%q<bundler>.freeze, ["~> 2.1.4"])
    s.add_development_dependency(%q<rake>.freeze, ["~> 12.0"])
  else
    s.add_dependency(%q<jekyll>.freeze, ["~> 3.8"])
    s.add_dependency(%q<jekyll-feed>.freeze, ["~> 0.9"])
    s.add_dependency(%q<jekyll-seo-tag>.freeze, ["~> 2.1"])
    s.add_dependency(%q<bundler>.freeze, ["~> 2.1.4"])
    s.add_dependency(%q<rake>.freeze, ["~> 12.0"])
  end
end
