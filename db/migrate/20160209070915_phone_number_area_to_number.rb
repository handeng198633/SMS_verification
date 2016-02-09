class PhoneNumberAreaToNumber < ActiveRecord::Migration
  def change
  	add_column :phone_numbers, :phone_number_area, :string
  end
end
