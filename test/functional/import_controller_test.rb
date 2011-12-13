require 'test_helper'

class ImportControllerTest < ActionController::TestCase
  test "should get godaddy" do
    get :godaddy
    assert_response :success
  end

  test "should get domainsite" do
    get :domainsite
    assert_response :success
  end

end
