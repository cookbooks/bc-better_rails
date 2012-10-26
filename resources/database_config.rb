def initialize(*args)
  super
  @action = :install
end

actions :install

attribute :rails_root, :kind_of => String, :name_attribute => true
attribute :owner, :kind_of => String
attribute :group, :kind_of => String
attribute :default_host, :kind_of => String
attribute :environments, :kind_of => Hash