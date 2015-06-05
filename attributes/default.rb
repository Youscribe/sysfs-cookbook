default['sysfs']['package'] = 'sysfsutils'
default['sysfs']['service'] = 'sysfsutils'

default['sysfs']['init_type'] = value_for_platform(
  %w(redhat centos) => {
    %w(6.0 6.1 6.2 6.3 6.4 6.5 6.6) => 'sysv',
    'default' => 'systemd'
  },
  'default' => nil
)

default['sysfs']['disable_tuned'] = value_for_platform(
  %w(redhat centos) => {
    %w(6.0 6.1 6.2 6.3 6.4 6.5 6.6) => false,
    'default' => true
  },
  'default' => false
)
