class Contact < ApplicationRecord
	validates :email, :title, :description, presence: true
	validates :description, presence: true
end
