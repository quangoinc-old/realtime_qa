class IssueNotesController < ApplicationController
  # GET /issue_notes
  # GET /issue_notes.json
  def index
    @issue_notes = IssueNote.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @issue_notes }
    end
  end

  # GET /issue_notes/1
  # GET /issue_notes/1.json
  def show
    @issue_note = IssueNote.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @issue_note }
    end
  end

  # GET /issue_notes/new
  # GET /issue_notes/new.json
  def new
    @issue_note = IssueNote.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @issue_note }
    end
  end

  # GET /issue_notes/1/edit
  def edit
    @issue_note = IssueNote.find(params[:id])
  end

  # POST /issue_notes
  # POST /issue_notes.json
  def create
    @issue_note = IssueNote.new(params[:issue_note])
    @issue_note.logged_by = current_user

    respond_to do |format|
      if @issue_note.save
        format.html { redirect_to @issue_note, notice: 'Issue note was successfully created.' }
        format.json { render json: @issue_note, status: :created, location: @issue_note }
      else
        format.html { render action: "new" }
        format.json { render json: @issue_note.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /issue_notes/1
  # PUT /issue_notes/1.json
  def update
    @issue_note = IssueNote.find(params[:id])

    respond_to do |format|
      if @issue_note.update_attributes(params[:issue_note])
        format.html { redirect_to @issue_note, notice: 'Issue note was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @issue_note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /issue_notes/1
  # DELETE /issue_notes/1.json
  def destroy
    @issue_note = IssueNote.find(params[:id])
    @issue_note.destroy

    respond_to do |format|
      format.html { redirect_to issue_notes_url }
      format.json { head :no_content }
    end
  end
end
