#
# Cookbook Name:: sysfs
# Provider:: sysfs
# Author:: Guilhem Lettron <guilhem.lettron@youscribe.com>
#
# Copyright 2012, Societe Publica.
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


action :save do
  ruby_block "add rule" do
    block do
      sysfsFile = Chef::Util::FileEdit.new('/etc/sysfs.conf')
      sysfsFile.insert_line_if_no_match(/#{getVariable}/, getVariable + ' = ' + new_resource.value)
      sysfsFile.write_file
    end
  end
  execute 'set value' do
    command 'echo "' + new_resource.value + '" >> /sys/' + getVariable
  end
  new_resource.updated_by_last_action(true)
end


action :set do
  execute 'set value' do
    command 'echo "' + new_resource.value + '" >> /sys/' + getVariable
  end
  new_resource.updated_by_last_action(true)
end


action :remove do
  ruby_block "add rule" do
    block do
      sysfsFile = Chef::Util::FileEdit.new('/etc/sysfs.conf')
      sysfsFile.search_file_delete_line(/#{getVariable}/)
      sysfsFile.write_file
    end
  end
  new_resource.updated_by_last_action(true)
end

def getVariable
  return new_resource.variable ? new_resource.variable : new_resource.name
end
