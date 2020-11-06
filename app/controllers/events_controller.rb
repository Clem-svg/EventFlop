class EventsController < ApplicationController
  before_action :authenticate_user, except: [:index, :show]
  before_action :is_admin?, only: [:edit, :update, :destroy]

  def new
    @event = Event.new
  end

  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def create
    @event = Event.new(post_params)
    @event.event_admin = current_user

    if @event.save
      redirect_to event_path(@event.id), success: "Evénement créé avec succès !"
    else
      render :new
    end
  end

  def edit
    @event = Event.find(params[:id])

  end

  def update
    @event = Event.find(params[:id])
    if @event.update(post_params)
      flash[:notice] = "Event édité !"
      redirect_to event_path(@event.id)
    else
      flash.now[:alert] = "Impossible d'éditer l'évènement' :"
      render :edit
    end
  end



  private

  def authenticate_user
    unless current_user
      flash[:danger] = "Il faut s'enregistrer bb"
      redirect_to new_user_session_path
    end
  end

  def post_params
    post_params = params.require(:event).permit(:start_date, :title, :duration, :description, :price, :location)
  end

    def is_admin?
    @event = Event.find(params[:id])
      unless @event.event_admin == current_user
        redirect_to @event, danger: "Vous n'êtes pas le créateur de cet évènement !!"
      end
    end





end
