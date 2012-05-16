#
# Cookbook Name:: chef-supervisor
# Recipe:: default
#
# Copyright 2012, Escape Studios
#

package "supervisor" do
	action :install
end

service "supervisor" do
	service_name "supervisor"
	start_command "/etc/init.d/supervisor start"
	stop_command "/etc/init.d/supervisor stop"
	restart_command "/etc/init.d/supervisor restart"
	status_command "/etc/init.d/supervisor status"
	supports value_for_platform(
		"default" => {
			"default" => [
				:start,
				:stop,
				:status
			]
		}
	)
	action :enable
end