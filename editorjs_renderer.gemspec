# frozen_string_literal: true

# editorjs_renderer.gemspec
require_relative "lib/editorjs_renderer/version"

Gem::Specification.new do |spec|
  spec.name = "editorjs_renderer"
  spec.version = EditorjsRenderer::VERSION
  spec.authors = ["Georgy Shcherbakov", "Sergey Arkhipov", "Grigory Paraschevin"]
  spec.email = %w[lordsynergymail@gmail.com sergey-arkhipov@ya.ru nedprofit@gmail.com]

  spec.summary = "Editor.js renderer for Ruby on Rails"
  spec.description = "Library for rendering and validating Editor.js documents in Rails applications"
  spec.homepage = "https://github.com/lordsynergy/editorjs_renderer"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.4"

  gemspec = File.basename(__FILE__)
  spec.files = if Dir.exist?(File.join(__dir__, ".git"))
                 IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
                   ls.readlines("\x0", chomp: true).reject do |f|
                     (f == gemspec) ||
                       f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
                   end
                 end
               else
                 Dir.glob("{lib,exe}/**/*", File::FNM_DOTMATCH).reject do |f|
                   File.directory?(f) || f.start_with?(*%w[bin/ test/ spec/ features/])
                 end
               end

  spec.require_paths = ["lib"]

  # Runtime
  spec.add_dependency "actionview", "~> 8.0"
  spec.add_dependency "activesupport", "~> 8.0"
  spec.add_dependency "json_schemer", "~> 2.4.0"

  spec.metadata = {
    "homepage_uri" => spec.homepage,
    "documentation_uri" => "#{spec.homepage}#readme",
    "changelog_uri" => "#{spec.homepage}/blob/master/CHANGELOG.md",
    "source_code_uri" => spec.homepage,
    "bug_tracker_uri" => "#{spec.homepage}/issues",
    "rubygems_mfa_required" => "true"
  }
end
