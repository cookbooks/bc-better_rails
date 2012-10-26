def prepared_database_configs
  environments = new_resource.environments

  {}.tap do |configs|
    environments.each do |environment_name, config|
      configs[environment_name] = {
        :db_name => config["db_name"],
        :db_user => config["db_user"],
        :db_pass => config["db_pass"],
        :db_host => (config["db_host"] || new_resource.default_host || "localhost")
      }
    end
  end
end


action :install do
  rails_root = new_resource.rails_root
  config_owner = new_resource.owner || "betterplace_deploy"
  config_group = new_resource.group || "betterplace"

  template ::File.join(rails_root, 'config', 'database.yml') do
    source "database.yml.erb"
    owner config_owner
    group config_group
    mode "0644"
    cookbook 'better_rails'
    variables(
      :database_configs => prepared_database_configs
    )
  end

  new_resource.updated_by_last_action(true)
end