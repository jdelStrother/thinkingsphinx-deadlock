class CreateAuditLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :audit_logs do |t|
      t.string :ip_address
      t.string :path

      t.timestamps
    end
  end
end
