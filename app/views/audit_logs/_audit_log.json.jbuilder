json.extract! audit_log, :id, :ip_address, :path, :created_at, :updated_at
json.url audit_log_url(audit_log, format: :json)
