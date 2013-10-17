#
# Cookbook Name:: supervisor
# Recipe:: programs
#
# Copyright 2012-2013, Escape Studios
#

#'remove' existing programs
#supervisor keeps on going with these 'removed' programs as long as it is not restarted
bash "remove_programs" do
	cwd "/etc/supervisor/conf.d/"
	code <<-EOH
		rm -f *.conf
	EOH
end

#'install' new programs
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
			#notifies :restart, "service[supervisor]"
			action :create
		end	
	end
end


if File.exists? "#{node.supervisor.sockfile}"
  execute "remove sockfile if exists" do
    command "unlink #{node.supervisor.sockfile}"
    user "root"  
  end
end

#we'll restart here rather than using a "notifies" on the template block above,
#just to cover the case we actually want to remove all programs and don't want to run any anymore 
service "supervisor" do
  action :restart
end
