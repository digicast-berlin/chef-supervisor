#
# Cookbook Name:: supervisor
# Recipe:: default
#
# Copyright 2012, Escape Studios
#

package "supervisor" do
	action :install
end

service "supervisor" do
	start_command "/etc/init.d/supervisor start"
	stop_command "/etc/init.d/supervisor stop"
	#restart_command "/etc/init.d/supervisor restart"
	status_command "/etc/init.d/supervisor status"
	supports [:start, :stop, :status]
	#starts the service if it's not running and enables it to start at system boot time
	action [:enable, :start]
end