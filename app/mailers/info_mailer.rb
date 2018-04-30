class InfoMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.info_mailer.form_contact.subject
  #
  def form_contact(contacto)
  	@correo = Contact.find(contacto.id)
    @greeting = "se puso en contacto contigo #{contacto.email}"

    mail(to: "mapv890@gmail.com", subject: @greeting)
  end
end
