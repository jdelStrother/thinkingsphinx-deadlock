class ApplicationController < ActionController::Base

  before_action do
    puts "Creating audit log..."
    AuditLog.create!(path: request.path, ip_address: request.remote_ip)
  end
end
