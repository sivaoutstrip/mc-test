# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception, unless: -> { request.format.json? }

  rescue_from ActionController::ParameterMissing, with: :handle_parameter_missing

  private

  def handle_parameter_missing(exception)
    respond_to do |format|
      format.html { redirect_back fallback_location: root_path, alert: exception.message }
      format.json do
        render json: { error: "#{exception.param.to_s.titleize} params missing" }, status: :unprocessable_entity
      end
    end
  end
end
