class Article < ApplicationRecord
	include PermissionsConcern
	has_many :has_categories
	has_many :comments
	has_many :categories, through: :has_categories
	after_create :save_categories
	belongs_to :user
	validates :title, :body, presence: true
	validate :valide_categories
	#:ultimos es el id que se le pasa al modelo del articulo ej Article.ultimos
	#scope :my_scope, ->(query) {condicion}
	scope :ultimos, -> {order("created_at DESC")}
	scope :titulo, -> (title) {where("title LIKE ?","#{title}%")}

	has_attached_file :img_art, styles: { 
		#thumb: {geometry: '320x240>', format: :png, convert_options: '-background white -gravity center -extend 320x240'},
		medium: {geometry: '300x300>', format: :png, convert_options: '-background white -gravity center -extent 300x300'},
		ban: {geometry: '320x320>', format: :png, convert_options: '-background white -gravity center -extent 630x315'},
		big: {geometry: '500x500>', format: :png, convert_options: '-background white -gravity center -extent 500x500'},
		 },
		default_url: "/images/:style/missing.png"
  	validates_attachment_content_type :img_art, content_type: /\Aimage\/.*\z/


	def categories=(value)
		@categories = value
	end
	def getCategories
		@categories
	end
	private
	def save_categories
		@categories.each do |cat|
			HasCategory.create(category_id: cat, article_id: self.id)
		end
	end
	#validacion personalizada
	def valide_categories
		if self.getCategories.blank?
			errors.add(:categories, "Elige una categoría")
		end
	end
end
