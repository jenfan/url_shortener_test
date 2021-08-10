class CreateShortUrls < ActiveRecord::Migration[6.1]
  def change
    create_table :short_urls, primary_key: :slug do |t|
      t.string :slug
      t.string :origin_url
      t.integer :show_count, default: 0

      t.timestamps
    end
    add_index :short_urls, :slug, unique: true
    add_index :short_urls, :origin_url, unique: true
  end
end
