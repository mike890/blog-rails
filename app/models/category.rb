class Category < ApplicationRecord
	has_many :has_categories
	has_many :articles, through: :has_categories
	belongs_to :user
	validates :name, :color, presence: true

	has_attached_file :cat_img, styles: { 
		#thumb: {geometry: '320x240>', format: :png, convert_options: '-background white -gravity center -extend 320x240'},
		medium: {geometry: '300x300>', format: :png, convert_options: '-background white -gravity center -extent 300x300'}
		 },
		default_url: "/images/:style/missing.png"
  	validates_attachment_content_type :cat_img, content_type: /\Aimage\/.*\z/
end
