class CreatePages < ActiveRecord::Migration
  def up
    create_table :pages do |t|
      t.belongs_to :category, index:true
      t.string :name
      t.integer :position
      t.boolean :visible, :default=>true
      t.timestamps null: false
    end
    #add_index("pages", "id_category")
  end

  def down
    drop_table :pages
  end
end
