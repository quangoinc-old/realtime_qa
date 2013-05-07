class CreateDeliverables < ActiveRecord::Migration
  def change
    create_table :deliverables do |t|
      t.string :name
      t.string :description
      t.string :status
      t.string :location

      t.timestamps
    end
  end
end
