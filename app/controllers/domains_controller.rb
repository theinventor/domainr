class DomainsController < ApplicationController

  def update_domain
    if current_user then
    @domain = Domain.find(params[:id])
    @domain.check_domain_now
    redirect_to "/domains", notice: "Domain updated"
    else
      redirect_to "/", notice: "Sorry, permission problem or something.."
    end
  end

  # GET /domains
  # GET /domains.json
  def index
    @domains = Domain.where('user_id = ?', current_user.id)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @domains }
    end
  end

  # GET /domains/1
  # GET /domains/1.json
  def show

    @domain = Domain.find(params[:id])
    if current_user.id != @domain.user_id
      redirect_to "/"
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @domain }
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

  # GET /domains/1/edit
  def edit
    @domain = Domain.find(params[:id])
  end

  # POST /domains
  # POST /domains.json
  def create
    @domain = Domain.new(params[:domain])
    @domain.user_id = current_user.id

    respond_to do |format|
      if @domain.save
        @domain.check_domain_now
        format.html { redirect_to @domain, notice: 'Domain was successfully created.' }
        format.json { render json: @domain, status: :created, location: @domain }
      else
        format.html { render action: "new" }
        format.json { render json: @domain.errors, status: :unprocessable_entity }
      end
    end
  end


end
