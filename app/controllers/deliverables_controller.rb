class DeliverablesController < ApplicationController
  # GET /projects
  # GET /projects.json
  def index
    @deliverables = Deliverable.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @deliverables }
    end
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @deliverable = Deliverable.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @deliverable }
    end
  end

  # GET /projects/new
  # GET /projects/new.json
  def new
    @deliverable = Deliverable.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @deliverable }
    end
  end

  # GET /projects/1/edit
  def edit
    @deliverable = Deliverable.find(params[:id])
  end

  # POST /projects
  # POST /projects.json
  def create
    @deliverable = Deliverable.new(params[:deliverable])
    @deliverable.status = 'open'

    respond_to do |format|
      if @deliverable.save
        format.html { redirect_to @deliverable, notice: 'Deliverable was successfully created.' }
        format.json { render json: @deliverable, status: :created, location: @deliverable }
      else
        format.html { render action: "new" }
        format.json { render json: @deliverable.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /projects/1
  # PUT /projects/1.json
  def update
    @deliverable = Deliverable.find(params[:id])

    respond_to do |format|
      if @deliverable.update_attributes(params[:deliverable])
        format.html { redirect_to @deliverable, notice: 'Deliverable was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @deliverable.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @deliverable = Deliverable.find(params[:id])
    @deliverable.destroy

    respond_to do |format|
      format.html { redirect_to projects_url }
      format.json { head :no_content }
    end
  end
end
