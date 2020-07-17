class AddAdminToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :admin, :boolean, default: false
  end
end

#default: falseは追記（本来記述不要だが、defaultでは管理者になれないことを明示するため）