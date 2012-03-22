require 'test_helper'

class FollowingsControllerTest < ActionController::TestCase
  def test_create_invalid
    Following.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Following.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to root_url
  end

  def test_destroy
    following = Following.first
    delete :destroy, :id => following
    assert_redirected_to root_url
    assert !Following.exists?(following.id)
  end
end
