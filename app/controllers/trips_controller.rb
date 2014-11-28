class TripsController < ApplicationController
  before_action :set_trip, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  helper_method :email

  def data
    user_trips = current_user.trips
    # trip_transportations = user_trips.map {|trip| trip.locations }
    # trip_accomodations = user_trips.pluck(:accomodation)
    # trip_accomodations = user_trips.pluck(:comment)
# COME BACK TO THIS MAN
    # lunch_dates = user_lunches.pluck(:lunch_date)
    render json: {trips: user_trips, user: current_user}
  end

  # GET /trips
  # GET /trips.json
  def index
    @trips = current_user.trips
  end

  # GET /trips/1
  # GET /trips/1.json
  def show
    @deadline_locations = @trip.deadline_locations
    @deadline_accomodations = @trip.deadline_accomodations
    @deadline_transportations = @trip.deadline_transportations
    # if deadline_locations < Time.now

    @locations = @trip.locations
    @transportations = @trip.transportations
    @accomodations = @trip.accomodations
    @comments = @trip.comments

  end

  def email
    model_name = params[:model]
    trip_id = params[:trip_id]

    TripMailer.data_update_notification(current_user, model_name, trip_id).deliver
    render json: {success: true}
  end

  class SendWeeklySummary
    def run
      User.find_each do |user|
        UserMailer.weekly_summary(user).deliver_now
      end
    end
  end
  # GET /trips/new
  def new
    @trip = Trip.new
  end

  # GET /trips/1/edit
  def edit
  end

  # POST /trips
  # POST /trips.json
  def create
    @trip = Trip.new(trip_params)
    @trip.owner = current_user
    # trip_params = deadline_params
    # Date.strptime(order_params[:scheduled_date], '%m/%d/%Y %I:%M %p')
    respond_to do |format|
      if @trip.save
        current_user.trip_users.create(user_id: current_user, trip_id: @trip.id)
        format.html { redirect_to @trip, notice: 'Trip was successfully created.' }
        format.json { render :show, status: :created, location: @trip, transportation: @trip, accomodation: @trip}
      else
        format.html { render :new }
        format.json { render json: @trip.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trips/1
  # PATCH/PUT /trips/1.json
  def update
    respond_to do |format|
      if @trip.update(trip_params)
        format.html { redirect_to @trip, notice: 'Trip was successfully updated.' }
        format.json { render :show, status: :ok, location: @trip, transportation: @trip, accomodation: @trip}
      else
        format.html { render :edit }
        format.json { render json: @trip.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trips/1
  # DELETE /trips/1.json
  def destroy
    @trip.destroy
    respond_to do |format|
      format.html { redirect_to trips_url, notice: 'Trip was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def upvote
    @trip = Trip.find(params[:id])
    @trip.liked_by current_user
    respond_to do |format|
      format.html {redirect_to :back }
      format.json { render json: { count: @trip.liked_count } }
    end
  end

  def downvote
    @trip = Trip.find(params[:id])
    @trip.disliked_by current_user
    respond_to do |format|
      format.html {redirect_to :back }
      format.json { render json: { count: @trip.liked_count } }
    end
  end

  def upvote_location
    @location = Location.find(params[:id])
    @location.liked_by current_user
    respond_to do |format|
      format.html {redirect_to :back }
      format.json { render json: { count: @location.liked_count } }
    end
  end

  def downvote_location
    @location = Location.find(params[:id])
    @location.disliked_by current_user
    respond_to do |format|
      format.html {redirect_to :back }
      format.json { render json: { count: @location.liked_count } }
    end
  end

  def upvote_transportation
    @transportation = Transportation.find(params[:id])
    @transportation.liked_by current_user
    respond_to do |format|
      format.html {redirect_to :back }
      format.json { render json: { count: @transportation.liked_count } }
    end
  end

  def downvote_transportation
    @transportation = Transportation.find(params[:id])
    @transportation.disliked_by current_user
    respond_to do |format|
      format.html {redirect_to :back }
      format.json { render json: { count: @transportation.liked_count } }
    end
  end

  def upvote_accomodation
    @accomodation = Accomodation.find(params[:id])
    @accomodation.liked_by current_user
    respond_to do |format|
      format.html {redirect_to :back }
      format.json { render json: { count: @accomodation.liked_count } }
    end
  end

  def downvote_accomodation
    @accomodation = Accomodation.find(params[:id])
    @accomodation.disliked_by current_user
    respond_to do |format|
      format.html {redirect_to :back }
      format.json { render json: { count: @accomodation.liked_count } }
    end
  end

  def upvote_comment
    @comment = Comment.find(params[:id])
    @comment.liked_by current_user
    respond_to do |format|
      format.html {redirect_to :back }
      format.json { render json: { count: @comment.liked_count } }
    end
  end

  def downvote_comment
    @comment = Comment.find(params[:id])
    @comment.disliked_by current_user
    respond_to do |format|
      format.html {redirect_to :back }
      format.json { render json: { count: @comment.liked_count } }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trip
      @trip = Trip.find(params[:id])
      @current_user = current_user
      @user_comments = @trip.comments.where(user_id: current_user)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trip_params
      params.require(:trip).permit(:name, :start_date, :end_date, :deadline_locations, :deadline_accomodations, :deadline_transportations,
        :locations_attributes => [:name, :id, :_destroy],
        :transportations_attributes => [:url, :id, :_destroy],
        :accomodations_attributes => [:url, :id, :_destroy],
        :comments_attributes => [:content, :id, :user_id, :_destroy])
    end
end
