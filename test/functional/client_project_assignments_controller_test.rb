require 'test_helper'

class ClientProjectAssignmentsControllerTest < ActionController::TestCase
  setup do
    @client_project_assignment = client_project_assignments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:client_project_assignments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create client_project_assignment" do
    assert_difference('ClientProjectAssignment.count') do
      post :create, client_project_assignment: { project_id: @client_project_assignment.project_id, user_id: @client_project_assignment.user_id }
    end

    assert_redirected_to client_project_assignment_path(assigns(:client_project_assignment))
  end

  test "should show client_project_assignment" do
    get :show, id: @client_project_assignment
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @client_project_assignment
    assert_response :success
  end

  test "should update client_project_assignment" do
    put :update, id: @client_project_assignment, client_project_assignment: { project_id: @client_project_assignment.project_id, user_id: @client_project_assignment.user_id }
    assert_redirected_to client_project_assignment_path(assigns(:client_project_assignment))
  end

  test "should destroy client_project_assignment" do
    assert_difference('ClientProjectAssignment.count', -1) do
      delete :destroy, id: @client_project_assignment
    end

    assert_redirected_to client_project_assignments_path
  end
end
