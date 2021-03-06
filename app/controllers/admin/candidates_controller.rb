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
      render "new", layout: 'no_sidebar'
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
      render 'edit', layout: 'no_sidebar'
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

  def setting
    render layout: 'no_sidebar'
  end

  def import_csv_new
    render layout: 'no_sidebar'
  end

  def import_csv
    if params[:csv_file].blank?
      redirect_to import_csv_new_admin_candidates_path
    else
      candidates = csv_save(params[:csv_file])
      candidates.each do |candidate|
        candidate.save
      end
      redirect_to admin_candidates_path
    end
  end

  private
  def self.sort
    order('created_at DESC')
  end

  def candidate_params
    params.require(:candidate).permit(:id, :name,:country_id,:city_id,:personal_url,:kind,:phone,:email,:image,:status,:probability, {candidate_details_attributes: [:id, :_destroy, :candidate_id,:kind,:sns_link]}, {candidate_memos_attributes: [:id, :_destroy, :candidate_id,:name,:memo]}, {candidate_progress_attributes: [:id, :_destroy, :candidate_id, :sent_at, :replied_at, :meeting_at]})
  end

  def csv_save(csv_file)
    require 'csv'
    require 'kconv'

    charactor = csv_file.read
    datas = []

    CSV.parse(charactor.kconv(Kconv::UTF8, Kconv::SJIS), headers: true) do |row|

      candidate = Candidate.new
      candidate.name = row[0]
      candidate.country_id = row[1]
      candidate.city_id = row[2]
      candidate.candidate_type_id = row[3]
      candidate.personal_url = row[4]
      candidate.phone = row[5]
      candidate.email = row[6]
      candidate.image = row[7]
      candidate.status = 1
      datas << candidate
    end
    datas
  end
end
