# encoding: utf-8
# vim:ft=ruby

guard 'pow' do
  watch('.powrc')
  watch('.powenv')
  watch('.rvmrc')
  watch('Gemfile.lock')
  watch('config/application.rb')
  watch('config/environment.rb')
  watch(%r{^config/environments/.*\.rb$})
  watch(%r{^config/initializers/.*\.rb$})
end

guard 'spork', :rspec_env => { 'RAILS_ENV' => 'test' }, :test_unit => false, :cucumber => true, :wait => 60 do
  watch('Gemfile.lock')
  watch('config/application.rb')
  watch('config/environment.rb')
  watch(%r{^config/environments/.+\.rb$})
  watch(%r{^config/initializers/.+\.rb$})
  watch(%r{^config/locales/.+\.yml})
  watch('spec/spec_helper.rb')
  watch(%r{^spec/support/(.+)\.rb$})                    { 'spec/' }
  watch(%w{^features/support/.+\.rb$})
  watch(%w{^features/step_definitions/.+\.rb$})
end

guard 'rspec', :version => 2, :cli => '--drb --color --format nested --fail-fast', :all_on_start => false, :all_after_pass => false, :notification => false do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})                             { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')                          { 'spec/' }
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^app/(.+)\.rb$})                             { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{^spec/support/(.+)\.rb$})                    { 'spec/' }
  watch('spec/spec_helper.rb')                          { 'spec/' }
  watch(%r{^spec/fabricators/(.+)_fabricator\.rb$})                 { |m| "spec/models/#{m[1]}_spec.rb" }
end

guard 'cucumber', :cli => '--drb --no-profile --color --format progress --strict', :all_on_start => false, :all_after_pass => false do
  watch(%r{^features/.+\.feature$})
  watch(%r{^features/support/.+$})                      { 'features' }
end
