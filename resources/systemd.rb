#
# Cookbook Name:: sysfs
# Resource:: sysfs_systemd
# Author:: Jonathan Morley <jmorley@cvent.com>
#
# Copyright 2016, Cvent Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

provides :sysfs do |node|
  node['init_package'] == 'systemd'
end

property :variable, String, name_attribute: true
property :value, String, required: true

action :save do
  service 'systemd-tmpfiles-setup' do
    action :enable
  end

  service 'tuned' do
    action :disable
  end

  systemd_tmpfile variable.gsub('/', '_') do
    action :create
    path "/sys/#{variable}"
    argument value
    type 'w'
  end
end

action :set do
  file "/sys/#{variable}" do
    content value
  end
end

action :remove do
  systemd_tmpfile variable.gsub('/', '_') do
    action :delete
  end
end
