class CreateSessionLogs < ActiveRecord::Migration[7.0]
  def change
    create_table :session_logs do |t|
      t.references :user, null: false, foreign_key: true
      t.jsonb :details

      t.timestamps
    end
  end
end
