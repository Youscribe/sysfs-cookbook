default['sysfs']['package'] = 'sysfsutils'
default['sysfs']['service'] = 'sysfsutils'

default['sysfs']['init_type'] = value_for_platform(
  %w(redhat centos) => {
    '< 7.0' => 'sysv',
    :default => 'systemd'
  },
  :default => nil
)

default['sysfs']['disable_tuned'] = value_for_platform(
  %w(redhat centos) => {
    '< 7.0' => false,
    :default => true
  },
  :default => false
)
