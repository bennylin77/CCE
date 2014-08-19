require 'test_helper'

class CceClassesControllerTest < ActionController::TestCase
  setup do
    @cce_class = cce_classes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cce_classes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cce_class" do
    assert_difference('CceClass.count') do
      post :create, cce_class: { available: @cce_class.available, class_time: @cce_class.class_time, dimension: @cce_class.dimension, end_at: @cce_class.end_at, enrollment_user: @cce_class.enrollment_user, future: @cce_class.future, introduction: @cce_class.introduction, kind: @cce_class.kind, lecturers: @cce_class.lecturers, location: @cce_class.location, member_id: @cce_class.member_id, note: @cce_class.note, schedule: @cce_class.schedule, start_at: @cce_class.start_at, status: @cce_class.status, sub_title: @cce_class.sub_title, syllabus: @cce_class.syllabus, title: @cce_class.title, tuition: @cce_class.tuition, user_size_limits: @cce_class.user_size_limits, verified: @cce_class.verified }
    end

    assert_redirected_to cce_class_path(assigns(:cce_class))
  end

  test "should show cce_class" do
    get :show, id: @cce_class
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cce_class
    assert_response :success
  end

  test "should update cce_class" do
    patch :update, id: @cce_class, cce_class: { available: @cce_class.available, class_time: @cce_class.class_time, dimension: @cce_class.dimension, end_at: @cce_class.end_at, enrollment_user: @cce_class.enrollment_user, future: @cce_class.future, introduction: @cce_class.introduction, kind: @cce_class.kind, lecturers: @cce_class.lecturers, location: @cce_class.location, member_id: @cce_class.member_id, note: @cce_class.note, schedule: @cce_class.schedule, start_at: @cce_class.start_at, status: @cce_class.status, sub_title: @cce_class.sub_title, syllabus: @cce_class.syllabus, title: @cce_class.title, tuition: @cce_class.tuition, user_size_limits: @cce_class.user_size_limits, verified: @cce_class.verified }
    assert_redirected_to cce_class_path(assigns(:cce_class))
  end

  test "should destroy cce_class" do
    assert_difference('CceClass.count', -1) do
      delete :destroy, id: @cce_class
    end

    assert_redirected_to cce_classes_path
  end
end
