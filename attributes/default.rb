default['sysfs']['disable_tuned'] = value_for_platform(
  %w(redhat centos) => {
    '< 7.0' => false,
    :default => true
  },
  :default => false
)
