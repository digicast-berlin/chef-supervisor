#
# Cookbook Name:: supervisor
# Recipe:: programs
#
# Copyright 2012, Escape Studios
#

programs = node['supervisor']['programs']

unless programs.nil?
	programs.keys.each do |key|
		template "/etc/supervisor/conf.d/#{programs[key]['name']}.conf" do
			source "program.conf.erb"
			owner "root"
			group "root"
			mode 0644
			variables(
				:name => programs[key]['name'],
				:command => programs[key]['command'],
				:stdout_logfile => programs[key]['stdout_logfile'],
				:autostart => programs[key]['autostart'],
				:autorestart => programs[key]['autorestart'],
				:user => programs[key]['user'],
				:startsecs => programs[key]['startsecs'],
				:numprocs => programs[key]['numprocs']
			)
			#restart doesn't work as expected:
			#changes in /etc/supervisor/conf.d/*.conf are not being picked up
			#so: we'll just stop and start the service (see below)
			#notifies :restart, "service[supervisor]"
			action :create
		end	
	end
end

#(see above) restart doesn't work as expected
#changes in /etc/supervisor/conf.d/*.conf are not being picked up
#so: we'll just stop and start the service
service "supervisor" do
  action :stop
end

service "supervisor" do
  action :start
end