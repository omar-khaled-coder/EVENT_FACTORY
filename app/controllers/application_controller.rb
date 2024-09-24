class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_currency_based_on_location

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :profile_picture, :govt_id_picture, :phone_number])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :profile_picture, :govt_id_picture, :phone_number])
  end

  private

  def set_currency_based_on_location
    if session[:currency].blank?
      location = request.location

      # Use location.country_code to determine the country based on IP
      if location.present? && location.country_code.present?
        country_code = location.country_code

        # Set currency based on the detected country code
        session[:currency] = case country_code
                             when "US" then "USD"
                             when "GB" then "GBP"
                             when "MY" then "MYR"  # Malaysia
                             when "EU" then "EUR"
                             # Add more country code to currency mappings here
                             else "USD"  # Default to USD if country not mapped
                             end

        Rails.logger.info "Detected country: #{country_code}, set currency: #{session[:currency]}"
      else
        session[:currency] = "USD"  # Default to USD if location is not detected
      end
    end
  end
end
