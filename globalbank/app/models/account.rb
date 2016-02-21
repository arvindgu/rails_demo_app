class Account < ActiveRecord::Base

attr_accessor :deposit_account, :deposit_account, :withdraw_amount

#validates :amount, :format => { :with => /\A\d+(?:\.\d{0,2})?\z/ }, :numericality => {:greater_than => 0}

end
