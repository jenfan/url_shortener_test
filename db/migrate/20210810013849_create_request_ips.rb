class CreateRequestIps < ActiveRecord::Migration[6.1]
  def change
    create_table :request_ip_stats, id: false do |t|
      t.string :ip
      t.integer :visit_count, default: 0

      t.timestamps
    end
    add_index :request_ip_stats, :ip
  end
end
