require 'test_helper'

class PublicControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get articles" do
    get :articles
    assert_response :success
  end

  test "should get galleries" do
    get :galleries
    assert_response :success
  end

  test "should get categories" do
    get :categories
    assert_response :success
  end

  test "should get news" do
    get :news
    assert_response :success
  end

  test "should get page" do
    get :page
    assert_response :success
  end

end
