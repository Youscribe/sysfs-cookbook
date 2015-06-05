require 'serverspec'

# Required by serverspec
set :backend, :exec

describe service('sysfsutils') do
  it { should be_enabled }
end
