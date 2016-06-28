#
# Cookbook Name:: sysfs
# Resource:: sysfs_init
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
  node['init_package'] == 'init' && node['platform_family'] != 'debian'
end

property :variable, String, name_attribute: true
property :value, String, required: true

action :save do
  cookbook_file '/etc/init.d/sysfsutils' do
    action :create
    source 'sysfsutils'
    cookbook 'sysfs'
    owner 'root'
    group 'root'
    mode '0755'
  end

  service 'sysfsutils' do
    action :enable
  end

  service 'tuned' do
    action :disable
  end

  cookbook_file '/etc/sysfs.conf' do
    action :create_if_missing
    source 'sysfs.conf'
    cookbook 'sysfs'
    owner 'root'
    group 'root'
    mode '0644'
  end

  directory '/etc/sysfs.d'
  file ::File.join '/etc/sysfs.d', variable.gsub('/', '_') do
    action :create
    content "#{variable} = #{value}"
  end

  action_set
end

action :set do
  file "/sys/#{variable}" do
    content value
  end
end

action :remove do
  file ::File.join '/etc/sysfs.d', variable.gsub('/', '_') do
    action :remove
  end
end
