require 'test_helper'

class LoginHistoriesControllerTest < ActionController::TestCase
  setup do
    @login_history = login_histories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:login_histories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create login_history" do
    assert_difference('LoginHistory.count') do
      post :create, login_history: { last_login: @login_history.last_login, user_id: @login_history.user_id }
    end

    assert_redirected_to login_history_path(assigns(:login_history))
  end

  test "should show login_history" do
    get :show, id: @login_history
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @login_history
    assert_response :success
  end

  test "should update login_history" do
    patch :update, id: @login_history, login_history: { last_login: @login_history.last_login, user_id: @login_history.user_id }
    assert_redirected_to login_history_path(assigns(:login_history))
  end

  test "should destroy login_history" do
    assert_difference('LoginHistory.count', -1) do
      delete :destroy, id: @login_history
    end

    assert_redirected_to login_histories_path
  end
end
