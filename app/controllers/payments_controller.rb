class PaymentsController < ApplicationController
	before_action :authenticate_user!
	before_action :payment_operation_user

	def index
		@user = User.find(params[:user_id])
		@payment= Payment.new
		@payments = @user.payments.order(id: "DESC")
		@paid_payment = @payments.where(created_at: Time.current.all_month)		
	end

	def create
		@user = User.find(params[:user_id])
		@payment= Payment.new(payment: Payment.this_month_payment, taxin_payment:  Payment.taxin_payment.floor, status: "支払い済み")
		@payment.user_id = @user.id
		@payment.save
		redirect_to user_payments_path(@user)
	end
	
	private
	def payment_operation_user
	    unless current_user.status == "講師"
	      redirect_to user_path(current_user)
	    end
	end
end
