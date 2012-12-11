# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard 'cucumber', cli: '--format pretty' do
  watch(%r{^features/.+\.feature$})
  watch(%r{^(?:features|lib)/.+\.rb$})          { 'features' }
end

guard 'rspec' do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})     { |m| "spec/#{m[1]}_spec.rb" }
end

