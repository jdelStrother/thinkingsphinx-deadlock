class AuditLogsController < ApplicationController
  before_action :set_audit_log, only: [:show, :edit, :update, :destroy]

  # GET /audit_logs
  # GET /audit_logs.json
  def index
    @audit_logs = AuditLog.all
  end

  # GET /audit_logs/1
  # GET /audit_logs/1.json
  def show
  end

  # GET /audit_logs/new
  def new
    @audit_log = AuditLog.new
  end

  # GET /audit_logs/1/edit
  def edit
  end

  # POST /audit_logs
  # POST /audit_logs.json
  def create
    @audit_log = AuditLog.new(audit_log_params)

    respond_to do |format|
      if @audit_log.save
        format.html { redirect_to @audit_log, notice: 'Audit log was successfully created.' }
        format.json { render :show, status: :created, location: @audit_log }
      else
        format.html { render :new }
        format.json { render json: @audit_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /audit_logs/1
  # PATCH/PUT /audit_logs/1.json
  def update
    respond_to do |format|
      if @audit_log.update(audit_log_params)
        format.html { redirect_to @audit_log, notice: 'Audit log was successfully updated.' }
        format.json { render :show, status: :ok, location: @audit_log }
      else
        format.html { render :edit }
        format.json { render json: @audit_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /audit_logs/1
  # DELETE /audit_logs/1.json
  def destroy
    @audit_log.destroy
    respond_to do |format|
      format.html { redirect_to audit_logs_url, notice: 'Audit log was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_audit_log
      @audit_log = AuditLog.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def audit_log_params
      params.require(:audit_log).permit(:ip_address, :path)
    end
end
