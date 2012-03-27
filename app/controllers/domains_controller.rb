class DomainsController < ApplicationController
  helper_method :sort_column, :sort_direction

  def update_domain
    if current_user
    @domain = Domain.find(params[:id])
    @domain.check_domain_now
    redirect_to "/domains", notice: "Domain updated"
    else
      redirect_to "/404.html"
    end
  end

  # GET /domains
  # GET /domains.json
  def index
    if current_user
      @domains = Domain.where('user_id = ?', current_user.id) 
      @domains = Domain.unscoped.where('user_id = ?', current_user.id).order(sort_column + " " + sort_direction) if params[:sort]
    else
      redirect_to "/", notice: "please login to view domains"
    end



  end

  # GET /domains/1
  # GET /domains/1.json
  def show

    @domain = Domain.find(params[:id])
    if current_user.id != @domain.user_id
      redirect_to "/404.html"
    end

  end

  # GET /domains/new
  # GET /domains/new.json
  def new
    @domain = Domain.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @domain }
    end
  end



  def create
    @domain = Domain.new(params[:domain])
    @domain.user_id = current_user.id
    @domain.domain = @domain.domain.downcase
    respond_to do |format|
      if @domain.save
        @domain.check_domain_now                           #HERE is where we manually update on create, so the after_create isn't in the way
        format.html { redirect_to @domain, notice: 'Domain was successfully created.' }
        format.json { render json: @domain, status: :created, location: @domain }
      else
        format.html { render action: "new" }
        format.json { render json: @domain.errors, status: :unprocessable_entity }
      end
    end
  end

  def search
    if current_user then
      puts "hi"
    else
      redirect_to "/", notice: "Sorry, permission problem or something.."
    end
    @domains = Domain.where("user_id = ? AND domain LIKE ?", current_user.id, "%#{params[:keyword]}%") if current_user
#    @domains = Domain.where("user_id = #{current_user.id} AND domain LIKE '%#{params[:keyword]}%'") if current_user
    respond_to do |format|
      format.html {render action: "index"}
    end
  end

  private

  def sort_column
    Domain.column_names.include?(params[:sort]) ? params[:sort] : "Domain"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end
