class SenddiscountController < ApplicationController
  def index
  	@workplaces = Workplace.all
  end

  def sendemail
  	PersonMailer.send_discount(params[:id]).deliver
  end

  def sendretrieve
  	PersonMailer.send_retrieve(params[:id]).deliver
  end
end