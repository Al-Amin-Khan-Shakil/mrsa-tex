class Admin < ApplicationRecord
  validates :f_name, presence: true, length: { maximum: 50 }
  validates :l_name, presence: true, length: { maximum: 50 }
  validates :role, presence: true, inclusion: { in: %w[superadmin admin manager staff], message: "%{value} is not a valid role" }
  validates :gender, presence: true, inclusion: { in: %w[male female other], message: "%{value} is not a valid gender" }
end
