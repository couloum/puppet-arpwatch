source ENV['GEM_SOURCE'] || 'https://rubygems.org'

gems = {}
gems['puppet'] = ENV['PUPPET_GEM_VERSION']
gems['facter'] = ''
gems['hiera'] = ''

gems.each do |gem_name, gem_params|
  gem gem_name, *gem_params
end
