class HeadDailiesController < ApplicationController
  before_filter :authenticate_user! 
  before_action :set_head_daily, only: [:show, :edit, :update, :destroy, :eliminar]

  respond_to :html

  def index
    HeadDaily.where.not(id: Daily.uniq(:head_daily_id).pluck(:head_daily_id)).destroy_all
    @tipo = params[:tipo] || nil
    @head_dailies = HeadDaily.with_tipo(@tipo).order(numero: :desc)
    respond_with(@head_dailies)
  end

  def show
    respond_with(@head_daily)
  end

  def new
    @head_daily = HeadDaily.new
    respond_with(@head_daily)
  end

  def edit
    respond_modal_with(@head_daily)
  end

  def create
    @head_daily = HeadDaily.new(head_daily_params)
    @head_daily.save
    respond_with(@head_daily)
  end

  def update
    @head_daily.update(head_daily_params)
    respond_with(@head_daily)
  end

  def destroy
    @head_daily.destroy
    respond_with(@head_daily)
  end

  def eliminar
    @head_daily.eliminar

    @head_dailies = HeadDaily.all.order(numero: :desc)
    render 'index'
  end

  def showtopdf
    @head_daily = HeadDaily.find(params[:id])

    render pdf: "#{@head_daily.tipo}#{@head_daily.numero}",  encoding: 'utf8', orientation: 'Landscape'
  end

  private
    def set_head_daily
      @head_daily = HeadDaily.find(params[:id])
    end

    def head_daily_params
      params.require(:head_daily).permit(:numero, :user_id, :tipo, :paguesea, :por, :mediopago, :banco, :recibidode, :numcheque, :documento)
    end
end
