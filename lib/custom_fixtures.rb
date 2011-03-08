require 'active_record/fixtures'

class Fixtures < (RUBY_VERSION < '1.9' ? YAML::Omap : Hash)
end
