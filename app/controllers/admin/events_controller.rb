class Admin::EventsController < Admin::BaseController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index
    @events = Event.order(:name)
  end

  def show
  end

  def new
    @event = Event.new
  end

  def edit
  end

  def create
    @event = Event.new(event_params)

    if @event.save
      redirect_to(
        admin_events_path(@event),
        success: "Successfully created #{@event.name}"
      )
    else
      render :new
    end
  end

  def update
    if @event.update(event_params)
      redirect_to(
        admin_events_path,
        success: "Successfully updated #{@event.name}"
      )
    else
      flash[:danger] = "Could not update this event. Please see errors."
      render :edit
    end
  end

  def destroy
    @event.destroy
    redirect_to(
      admin_events_path,
      success: "Successfully destroyed #{@event.name}"
    )
  end

  private

  def set_event
    @event = Event.friendly.find(params[:id])
  end

  def event_params
    params.require(:event).permit!
  end
end
