class Admin::CitiesController < Admin::BaseController
  def index
    @cities = City.all
    render layout: 'no_sidebar'
  end

  def new
    @city = City.new
    render layout: 'no_sidebar'
  end

  def create
    @city = City.new(city_params)
    if @city.save
      redirect_to admin_cities_path
    else
      render "new"
    end
  end

  def city_params
    params.require(:city).permit(:country_id, :title)
  end

end
