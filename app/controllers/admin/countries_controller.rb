class Admin::CountriesController < Admin::BaseController
  def index
    @countries = Country.all
    render layout: 'no_sidebar'
  end

  def new
    @country = Country.new
    render layout: 'no_sidebar'
  end

  def create
    @country = Country.new(country_params)
    if @country.save
      redirect_to admin_countries_path
    else
      render "new"
    end
  end

  def country_params
    params.require(:country).permit(:title)
  end


end
