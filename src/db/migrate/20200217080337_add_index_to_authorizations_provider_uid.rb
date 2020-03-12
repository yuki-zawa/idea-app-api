class AddIndexToAuthorizationsProviderUid < ActiveRecord::Migration[6.0]
  def change
    add_index :authorizations, [:provider, :uid], unique: true
  end
end
