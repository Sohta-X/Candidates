class Admin::CandidateTypesController < Admin::BaseController
  def index
    @candidate_types = CandidateType.all
    render layout: 'no_sidebar'
  end

  def new
    @candidate_type = CandidateType.new
    render layout: 'no_sidebar'
  end

  def create
    @candidate_type = CandidateType.new(candidate_type_params)
    if @candidate_type.save
      redirect_to admin_candidate_types_path
    else
      render "new"
    end
  end

  def candidate_type_params
    params.require(:candidate_type).permit(:title)
  end
end
