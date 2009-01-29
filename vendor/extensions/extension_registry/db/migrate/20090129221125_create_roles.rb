class CreateRoles < ActiveRecord::Migration
  def self.up
      Role.create(:role_name => 'Author', 
                  :allow_empty => true, 
                  :description => 'Extension Author role')

  end

  def self.down
  end
end
