require 'test_helper'

class TooltipsControllerTest < ActionController::TestCase
  setup do
    @tooltip = tooltips(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tooltips)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tooltip" do
    assert_difference('Tooltip.count') do
      tooltip = Tooltip.new({:title => 'foo', :content => 'bar'})
      post :create, :tooltip => tooltip.attributes
    end

    assert_redirected_to tooltip_path(assigns(:tooltip))
  end

  test "should show tooltip" do
    get :show, :id => @tooltip.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @tooltip.to_param
    assert_response :success
  end

  test "should update tooltip" do
    put :update, :id => @tooltip.to_param, :tooltip => @tooltip.attributes
    assert_redirected_to tooltip_path(assigns(:tooltip))
  end

  test "should destroy tooltip" do
    assert_difference('Tooltip.count', -1) do
      delete :destroy, :id => @tooltip.to_param
    end

    assert_redirected_to tooltips_path
  end
  
  # Add tests for the ajax functions....
  
  # tooltip_content
  test "should show tooltip content given a title" do
    get :tooltip_content, :title => @tooltip.title
    assert_response :success
  end

end
