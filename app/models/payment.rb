class Payment < ApplicationRecord
	belongs_to :user

	enum status: { 未払い: 0, 支払い済み: 1 }

	def self.this_month_payment
		5000
	end

	def self.tax
		1.1
	end

	def self.taxin_payment
		self.this_month_payment * self.tax
	end
end
