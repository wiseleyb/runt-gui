require 'test_helper'

class ScheduleDetailsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:schedule_details)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create schedule_detail" do
    assert_difference('ScheduleDetail.count') do
      post :create, :schedule_detail => { }
    end

    assert_redirected_to schedule_detail_path(assigns(:schedule_detail))
  end

  test "should show schedule_detail" do
    get :show, :id => schedule_details(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => schedule_details(:one).id
    assert_response :success
  end

  test "should update schedule_detail" do
    put :update, :id => schedule_details(:one).id, :schedule_detail => { }
    assert_redirected_to schedule_detail_path(assigns(:schedule_detail))
  end

  test "should destroy schedule_detail" do
    assert_difference('ScheduleDetail.count', -1) do
      delete :destroy, :id => schedule_details(:one).id
    end

    assert_redirected_to schedule_details_path
  end
end
