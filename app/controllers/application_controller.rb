class ApplicationController < ActionController::Base
  around_action :kill_long_requests
  def kill_long_requests
    # Add a timeout so that when we do manage to reproduce the deadlock, we don't have to kill -9 the process.
    Timeout.timeout(15) do
      yield
    end
  rescue Timeout::Error => e
    logger.info "Hit timeout.  Deadlock?"
    raise
  end

  # A debugging aid so you can call, eg, localhost:3000/posts?set_mutex=fixed to experiment with
  # the alternative mutex implementation.
  before_action do
    case params[:set_mutex]
    when "original"
      ThinkingSphinx::Configuration.class_variable_set("@@mutex", Mutex.new)
      render plain: "Changed TS mutex back to original implementation"

    when "fixed"
      ThinkingSphinx::Configuration.class_variable_set("@@mutex", ActiveSupport::Concurrency::LoadInterlockAwareMonitor.new)
      render plain: "Changed TS mutex to fixed implementation"
    end
  end


  before_action do
    logger.info "TS mutex is #{ThinkingSphinx::Configuration.class_variable_get("@@mutex").class}"
    logger.info "Creating audit log..."
    # Here's the problem-point.  ThinkingSphinx has a before_save callback, which will invoke preload_indices, which results in a deadlock in ActiveSupport::Dependencies
    AuditLog.create!(path: request.path, ip_address: request.remote_ip)
    logger.info "Created!"
  end
end
