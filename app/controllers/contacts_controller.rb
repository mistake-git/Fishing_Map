class ContactsController < ApplicationController
  def new
    @contact = Contact.new
    @form_title = "お問い合わせ"
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save!
      ContactMailer.contact_mail(@contact).deliver
      flash[:success] = 'お問い合わせを受け付けました'
      redirect_back(fallback_location: root_path)
    else
      render :new
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :message)
  end
end
