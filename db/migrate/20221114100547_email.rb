class AddUserMail < ActiveRecord::Migration[6.0]
  def change
    add_column: email, email:, :string
  end
end
