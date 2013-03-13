name             "supervisor"
maintainer       "Escape Studios"
maintainer_email "dev@escapestudios.com"
license          "MIT"
description      "Installs/Configures supervisor"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.3"

%w{ debian ubuntu }.each do |os|
supports os
end

recipe "supervisor", "Installs supervisor."
recipe "supervisor::programs", "Configures supervisor programs."