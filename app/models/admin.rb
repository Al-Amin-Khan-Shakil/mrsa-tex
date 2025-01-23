class Admin < ApplicationRecord
  devise :database_authenticatable, :recoverable, :validatable

  ROLES = %w[super_admin admin manager staff].freeze
  GENDERS = %w[male female other].freeze

  validates :f_name, presence: true, length: { maximum: 50 }
  validates :l_name, presence: true, length: { maximum: 50 }
  validates :phone_number, presence: true, format: { with: /\A\+?[0-9]+\z/, message: 'Must be a valid phone number' }
  validates :role, presence: true, inclusion: { in: ROLES, message: '%<value>s is not a valid role' }
  validates :gender, presence: true, inclusion: { in: GENDERS, message: '%<value>s is not a valid gender' }
  validates :password,
            presence: { message: 'Password can not be blank' },
            confirmation: { message: ' Password confirmation does not match' },
            length: { within: 8..128, message: 'Password must be between 8 and 128 characters long' },
            format: { with: /\A(?=.*[a-zA-Z])(?=.*\d).+\z/,
                      message: 'Must include at least one letter and one number' },
            if: :password_required?

  ROLES.each do |role_name|
    define_method "#{role_name.gsub(' ', '_')}?" do
      role == role_name.tr('_', ' ')
    end
  end

  GENDERS.each do |gender_name|
    define_method "#{gender_name.gsub(' ', '_')}?" do
      gender == gender_name.tr('_', ' ')
    end
  end

  private

  def password_required?
    new_record? || password.present?
  end
end
