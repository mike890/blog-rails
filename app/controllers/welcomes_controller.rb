class WelcomesController < ApplicationController
  
  def index
  	@articles = Article.all
  end

  def contactos
  	@contacts = Contact.new
  end
end
