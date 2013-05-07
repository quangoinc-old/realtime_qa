class ClientProjectAssignmentsController < ApplicationController
  # GET /client_project_assignments
  # GET /client_project_assignments.json
  def index
    @client_project_assignments = ClientProjectAssignment.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @client_project_assignments }
    end
  end

  # GET /client_project_assignments/1
  # GET /client_project_assignments/1.json
  def show
    @client_project_assignment = ClientProjectAssignment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @client_project_assignment }
    end
  end

  # GET /client_project_assignments/new
  # GET /client_project_assignments/new.json
  def new
    @client_project_assignment = ClientProjectAssignment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @client_project_assignment }
    end
  end

  # GET /client_project_assignments/1/edit
  def edit
    @client_project_assignment = ClientProjectAssignment.find(params[:id])
  end

  # POST /client_project_assignments
  # POST /client_project_assignments.json
  def create
    @client_project_assignment = ClientProjectAssignment.new(params[:client_project_assignment])

    respond_to do |format|
      if @client_project_assignment.save
        format.html { redirect_to @client_project_assignment, notice: 'Client project assignment was successfully created.' }
        format.json { render json: @client_project_assignment, status: :created, location: @client_project_assignment }
      else
        format.html { render action: "new" }
        format.json { render json: @client_project_assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /client_project_assignments/1
  # PUT /client_project_assignments/1.json
  def update
    @client_project_assignment = ClientProjectAssignment.find(params[:id])

    respond_to do |format|
      if @client_project_assignment.update_attributes(params[:client_project_assignment])
        format.html { redirect_to @client_project_assignment, notice: 'Client project assignment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @client_project_assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /client_project_assignments/1
  # DELETE /client_project_assignments/1.json
  def destroy
    @client_project_assignment = ClientProjectAssignment.find(params[:id])
    @client_project_assignment.destroy

    respond_to do |format|
      format.html { redirect_to client_project_assignments_url }
      format.json { head :no_content }
    end
  end
end
