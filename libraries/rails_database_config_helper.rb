class RailsDatabaseConfigHelper

  class DatabaseConfig
    attr_accessor :environments
  end

  class EnvironmentConfig
    attr_accessor :database
  end

  attr_reader :db_settings, :environment_settings, :databases, :environments

  def initialize(db_settings, environment_settings)
    @databases = setup_databases(db_settings)
    @environments = setup_environments(environment_settings)
    connect_databases_and_environments!
  end

  private

  def setup_environments(environment_settings)
    
  end
end