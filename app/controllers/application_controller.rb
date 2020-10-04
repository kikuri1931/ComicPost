class ApplicationController < ActionController::Base
	def configure_permitted_parameters
	    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :name_kana, :postal_code, :address, :telephone_number, :is_deleted, :status])
  	end
end
