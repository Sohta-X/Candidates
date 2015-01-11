class Admin::CandidatesController < Admin::BaseController
  def index
    @query = Candidate.search(params[:q])
    @candidates = @query.result(distict: true).order('created_at DESC')
  end

  def show
    @candidate = Candidate.find(params[:id])
    @candidate_details = @candidate.candidate_details.sort
    @candidate_memos = @candidate.candidate_memos.sort
    render layout: 'no_sidebar'
  end

  def new
    @candidate = Candidate.new
    @candidate.candidate_memos.build
    @candidate.candidate_details.build
    render layout: 'no_sidebar'
  end

  def create
    @candidate = Candidate.new(candidate_params)
    if @candidate.save
      redirect_to admin_candidates_path
    else
      @candidate.candidate_memos.build
      @candidate.candidate_details.build
      render "new"
    end
  end

  def edit
    @candidate = Candidate.find(params[:id])
    @candidate.candidate_details.build
    @candidate.candidate_memos.build
    render layout: 'no_sidebar'
  end

  def update
    @candidate = Candidate.find(params[:id])
    if @candidate.update_attributes(candidate_params)
      redirect_to admin_candidates_path
    else
      render 'edit'
      @candidate.candidate_details.build
      @candidate.candidate_memos.build
    end
  end

  def progress
    @query = Candidate.search(params[:q])
    @candidates = @query.result(distict: true).order('created_at DESC')
  end

  def progress_update
    @candidate_ids = params[:candidates]
    @candidate_ids.each do |id|
      @candidate = Candidate.find(id)
      @candidate_progress = @candidate.candidate_progress
      if @candidate_progress.present?
        @candidate_progress.update(candidate_id: id, sent_at: Date.today)
      else
        @candidate_progress = CandidateProgress.new(candidate_id: id, sent_at: Date.today)
        @candidate_progress.save
      end
    end
    redirect_to progress_admin_candidates_path
  end

  def probability_candidates
    @query = Candidate.search(params[:q])
    @candidates = @query.result(distict: true).where(probability: 1).order('created_at DESC')
  end

  def reply
    @candidate = Candidate.find(params[:candidate_id])
    @candidate_progress = @candidate.candidate_progress
    if @candidate_progress.present?
      @candidate_progress.update(replied_at: Date.today)
    else
      @candidate_progress = CandidateProgress.new(candidate_id: params[:candidate_id], replied_at: Date.today)
      @candidate_progress.save
    end
    redirect_to progress_admin_candidates_path
  end

  def meeting
    @candidate = Candidate.find(params[:candidate_id])
    @candidate_progress = @candidate.candidate_progress
    if @candidate_progress.present?
      @candidate_progress.update(meeting_at: Date.today)
    else
      @candidate_progress = CandidateProgress.new(candidate_id: params[:candidate_id], meeting_at: Date.today)
      @candidate_progress.save
    end
    redirect_to progress_admin_candidates_path
  end

  private
  def self.sort
    order('created_at DESC')
  end

  def candidate_params
    params.require(:candidate).permit(:name,:country_id,:city_id,:personal_url,:kind,:phone,:email,:image,:status,:probability, {candidate_details_attributes: [:candidate_id,:kind,:sns_link]}, {candidate_memos_attributes: [:candidate_id,:name,:memo]}, {candidate_progress_attributes: [:candidate_id, :sent_at, :replied_at, :meeting_at]})
  end

end
