class Admin < ApplicationRecord
  devise :database_authenticatable, :recoverable, :validatable

  has_one_attached :profile_picture

  ROLES = { super_admin: 1, admin: 2, manager: 3, staff: 4 }.freeze
  GENDERS = { male: 1, female: 2, other: 3 }.freeze

  validates :f_name, presence: true, length: { maximum: 50 }
  validates :l_name, presence: true, length: { maximum: 50 }
  validates :phone_number, presence: true, format: { with: /\A\+?[0-9]+\z/, message: 'Must be a valid phone number' }
  validates :role, presence: true, inclusion: { in: ROLES.values, message: '%<value>s is not a valid role' }
  validates :gender, presence: true, inclusion: { in: GENDERS.values, message: '%<value>s is not a valid gender' }
  validates :password,
            presence: { message: 'Password can not be blank' },
            confirmation: { message: 'Password confirmation does not match' },
            length: { within: 8..128, message: 'Password must be between 8 and 128 characters long' },
            format: {
              with: %r{\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()_+={}\[\]:;"'<>,.?/\\|-]).+\z},
              message: 'Password must include at least one uppercase letter, one lowercase letter,' \
                       'one number, and one special character (e.g., !@#$%^&*)'
            },
            if: :password_required?
  validates :profile_picture,
            content_type: {
              in: %w[image/png image/jpg image/jpeg],
              message: 'must be a PNG, JPG, or JPEG file.'
            },
            size: {
              less_than: 2.megabytes,
              message: 'is too large (maximum size is 2MB).'
            }

  ROLES.each do |role_name, value|
    define_method "#{role_name}?" do
      role == value
    end
  end

  GENDERS.each do |gender_name, value|
    define_method "#{gender_name}?" do
      gender == value
    end
  end

  private

  def password_required?
    new_record? || password.present?
  end
end
