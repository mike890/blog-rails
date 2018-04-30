class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  protected
  def authenticate_editor!
  	redirect_to root_path, notice: "No tienes permisos para este apartado" unless user_signed_in? && current_user.is_editor?
  end
  def authenticate_admin!
  	redirect_to root_path, notice: "No tienes suficientes permisos para este apartado" unless user_signed_in? && current_user.is_admin? 		
  end
end
