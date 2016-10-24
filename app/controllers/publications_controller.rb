class PublicationsController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :create, :edit, :update, :create, :destroy]
  before_action :set_publication, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @tipo = params[:tipo] || nil
    @publications = Publication.with_tipo(@tipo).order(created_at: :desc)
    respond_with(@publications)
  end

  def show
    respond_with(@publication)
  end

  def new
    @publication = Publication.new
    respond_with(@publication)
  end

  def edit
  end

  def create
    @publication = Publication.new(publication_params)
    @publication.save
    respond_with(@publication)
  end

  def update
    @publication.update(publication_params)
    respond_with(@publication)
  end

  def destroy
    @publication.destroy
    respond_with(@publication)
  end

  private
    def set_publication
      @publication = Publication.find(params[:id])
    end

    def publication_params
      params.require(:publication).permit(:titulo, :texto, :resumen, :imagen, :tipo, :documeto, :estado, :web)
    end
end
