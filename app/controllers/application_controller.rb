class ApplicationController < ActionController::Base
  after_action :save_request_ip

  protected

  def save_request_ip
    request_api = RequestIpStat.find_or_create_by(ip: request.remote_ip)
    request_api.visit_count += 1
    request_api.save
  end
end
