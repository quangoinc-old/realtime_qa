require 'test_helper'

class IssueNotesControllerTest < ActionController::TestCase
  setup do
    @issue_note = issue_notes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:issue_notes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create issue_note" do
    assert_difference('IssueNote.count') do
      post :create, issue_note: { content: @issue_note.content, issue_id: @issue_note.issue_id, logged_by: @issue_note.logged_by }
    end

    assert_redirected_to issue_note_path(assigns(:issue_note))
  end

  test "should show issue_note" do
    get :show, id: @issue_note
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @issue_note
    assert_response :success
  end

  test "should update issue_note" do
    put :update, id: @issue_note, issue_note: { content: @issue_note.content, issue_id: @issue_note.issue_id, logged_by: @issue_note.logged_by }
    assert_redirected_to issue_note_path(assigns(:issue_note))
  end

  test "should destroy issue_note" do
    assert_difference('IssueNote.count', -1) do
      delete :destroy, id: @issue_note
    end

    assert_redirected_to issue_notes_path
  end
end
