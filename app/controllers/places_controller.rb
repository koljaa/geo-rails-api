class PlacesController < ApplicationController
	before_action :set_place, only: [:show, :update, :destroy]


	def index
    @places = Place.all
    json_response(@places)
  end

  # POST /places
  def create
    @place = Place.create!(place_params)
    json_response(@place, :created)
  end

  # GET /places/:id
  def show
    json_response(@place)
  end

  # PUT /places/:id
  def update
    @place.update(place_params)
    head :no_content
  end

  # DELETE /places/:id
  def destroy
    @place.destroy
    head :no_content
  end

  private

  def place_params
  	params.permit(:name, :lonlat)
  end

   def set_place
    @place = Place.find(params[:id])
  end

  def json_response(object, status = :ok)
    render json: object, status: status
  end

end
