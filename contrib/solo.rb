
require 'pathname'

Chef::Config[:git_repo] = "git://github.com/dlobue/chef-test.git"
Chef::Config[:git_branch] = "master"

contrib_dir = Pathname.new(__FILE__).realpath.dirname
json_attribs (contrib_dir + "chef_attribs.json").to_s

Chef::Config[:work_dir] = contrib_dir.parent.to_s

cookbook_names = %w{cookbooks}
cookbook_path cookbook_names.map {|d| Chef::Config[:work_dir] + "/" + d }

role_path "#{Chef::Config[:work_dir]}/roles"
data_bag_path "#{Chef::Config[:work_dir]}/data_bags"
file_cache_path "#{Chef::Config[:work_dir]}/cache"
file_backup_path "#{Chef::Config[:work_dir]}/backup"
cache_options({ :path => "#{Chef::Config[:work_dir]}/cache/checksums", :skip_expires => true })
Chef::Log::Formatter.show_time = true

require (contrib_dir.parent + 'bootstrap' + 'git_pull_cookbooks').to_s

