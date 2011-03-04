require 'test_helper'

class SimpleTooltipsControllerTest < ActionController::TestCase
  setup do
    @simple_tooltip = simple_tooltips(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:simple_tooltips)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create simple_tooltip" do
    assert_difference('SimpleTooltip.count') do
      simple_tooltip = SimpleTooltip.new({:title => 'foo', :content => 'bar'})
      post :create, :simple_tooltip => simple_tooltip.attributes
    end

    assert_redirected_to simple_tooltip_path(assigns(:simple_tooltip))
  end

  test "should show simple_tooltip" do
    get :show, :id => @simple_tooltip.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @simple_tooltip.to_param
    assert_response :success
  end

  test "should update simple_tooltip" do
    put :update, :id => @simple_tooltip.to_param, :simple_tooltip => @simple_tooltip.attributes
    assert_redirected_to simple_tooltip_path(assigns(:simple_tooltip))
  end

  test "should destroy simple_tooltip" do
    assert_difference('SimpleTooltip.count', -1) do
      delete :destroy, :id => @simple_tooltip.to_param
    end

    assert_redirected_to simple_tooltips_path
  end
  
  # Add tests for the ajax functions....
  
  # tooltip_content
  test "should show tooltip content given a title" do
    get :tooltip_content, :title => @simple_tooltip.title
    assert_response :success
  end

end
