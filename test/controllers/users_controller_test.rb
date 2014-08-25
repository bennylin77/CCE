require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, user: { address: @user.address, age: @user.age, birthday: @user.birthday, education: @user.education, email: @user.email, extend: @user.extend, gender: @user.gender, hashed_pw: @user.hashed_pw, id_no: @user.id_no, identity: @user.identity, mobile_no: @user.mobile_no, name: @user.name, nationality: @user.nationality, passport_no: @user.passport_no, phone_no: @user.phone_no, salt: @user.salt }
    end

    assert_redirected_to user_path(assigns(:user))
  end

  test "should show user" do
    get :show, id: @user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user
    assert_response :success
  end

  test "should update user" do
    patch :update, id: @user, user: { address: @user.address, age: @user.age, birthday: @user.birthday, education: @user.education, email: @user.email, extend: @user.extend, gender: @user.gender, hashed_pw: @user.hashed_pw, id_no: @user.id_no, identity: @user.identity, mobile_no: @user.mobile_no, name: @user.name, nationality: @user.nationality, passport_no: @user.passport_no, phone_no: @user.phone_no, salt: @user.salt }
    assert_redirected_to user_path(assigns(:user))
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end

    assert_redirected_to users_path
  end
end
