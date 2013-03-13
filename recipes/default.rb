#
# Cookbook Name:: supervisor
# Recipe:: default
#
# Copyright 2012-2013, Escape Studios
#

package "supervisor" do
	action :install
end

service "supervisor" do
	start_command "/etc/init.d/supervisor start"
	stop_command "/etc/init.d/supervisor stop"
	#restart_command "/etc/init.d/supervisor restart"
	#But: "/etc/init.d/supervisor restart" doesn't work as expected:
	#changes in /etc/supervisor/conf.d/*.conf are not being picked up,
	#so: we'll just stop and start the service when we need to restart.
	#Actually:
	#:restart - the init script or other service provider can use a restart command. If this is not specified, Chef will attempt to stop then start the service.
	#(source: http://wiki.opscode.com/display/chef/Resources)
	#...so there's no need for this explicitly:
	#restart_command "/etc/init.d/supervisor stop; /etc/init.d/supervisor start"
	status_command "/etc/init.d/supervisor status"
	supports [:start, :stop, :status]
	#starts the service if it's not running and enables it to start at system boot time
	action [:enable, :start]
end