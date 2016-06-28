describe file('/sys/block/sda/queue/scheduler') do
  it { should be_file }
  its('content') { should match 'noop' }
end

describe file('/sys/power/disk') do
  it { should be_file }
  its('content') { should match 'reboot' }
end
