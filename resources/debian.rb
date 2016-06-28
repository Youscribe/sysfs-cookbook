#
# Cookbook Name:: sysfs
# Resource:: sysfs_debian
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

provides :sysfs, platform_family: 'debian'

property :variable, String, name_attribute: true
property :value, String, required: true

action :save do
  package 'sysfsutils'
  service 'sysfsutils' do
    action :enable
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
