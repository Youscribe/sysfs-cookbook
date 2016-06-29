sysfs 'block/sda/queue/scheduler' do
  value 'noop'
end

sysfs 'power/disk' do
  action :set
  value 'reboot'
end
