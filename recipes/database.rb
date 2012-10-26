include_recipe "rails"
include_recipe "build-essential"
include_recipe "database"

gem_package "mysql"

node.set_unless['rails']['db_pass'] = secure_password

databases = node['rails']['environments'].map { |env| [env, node['rails']['app_name']].join('_') }

databases.each do |db_name|

	log "Setting up database #{db_name}"

	mysql_database db_name do
  	connection(:host => "localhost", :username => 'root', :password => node['mysql']['server_root_password'])
  	action :create
	end

	mysql_database_user 'betterplace' do
	  connection(:host => "localhost", :username => 'root', :password => node['mysql']['server_root_password'])
	  password node['rails']['db_pass']
	  database_name db_name
	  host '%'
	  privileges [:all]
	  action :grant
	end
end

rails_database_config node['rails']['root'] do
	db_host (node['rails']['db_host'] || 'localhost')
	db_user (node['rails']['db_user'] || node['rails']['app_name'] || 'root')
	db_pass node['rails']['db_pass']
	environments node['rails']['environments']
end