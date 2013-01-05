Description
===========

Set sysfs values from Chef!

Attributes
==========

Usage
=====

With Ressource/Provider.

Resource/Provider
=================

sysfs
------

## Actions

- **:save** - Save and set a sysfs value (default).
- **:set** - Set a sysfs value.
- **:remove** - Remove a (previous set) sysfs.

## Attribute Parameters

- **variable** - Variable to manage. e.g. `devices/system/cpu/cpu0/cpufreq/scaling_governor`, `block/sda/queue/scheduler`.
- **value** - Value to affect to variable. e.g. `1`, `0`, `noop`.

## Examples

```ruby
sysfs 'block/sda/queue/scheduler' do
  value 'noop'
end
   
# the same.
sysfs 'set io scheduler to cfq' do
  variable 'block/sda/queue/scheduler'
  value 'cfq'
end

sysfs 'block/sda/queue/scheduler' do
  action :remove
end

# Set set scaling governator but don't save it.
sysfs 'devices/system/cpu/cpu0/cpufreq/scaling_governor' do
  action :set
  value 'powersave'
end
