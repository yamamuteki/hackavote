require 'test_helper'

class Vote2sControllerTest < ActionController::TestCase
  setup do
    @vote2 = vote2s(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:vote2s)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create vote2" do
    assert_difference('Vote2.count') do
      post :create, vote2: { point1: @vote2.point1, point2: @vote2.point2, point3: @vote2.point3, team_no: @vote2.team_no }
    end

    assert_redirected_to vote2_path(assigns(:vote2))
  end

  test "should show vote2" do
    get :show, id: @vote2
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @vote2
    assert_response :success
  end

  test "should update vote2" do
    patch :update, id: @vote2, vote2: { point1: @vote2.point1, point2: @vote2.point2, point3: @vote2.point3, team_no: @vote2.team_no }
    assert_redirected_to vote2_path(assigns(:vote2))
  end

  test "should destroy vote2" do
    assert_difference('Vote2.count', -1) do
      delete :destroy, id: @vote2
    end

    assert_redirected_to vote2s_path
  end
end
