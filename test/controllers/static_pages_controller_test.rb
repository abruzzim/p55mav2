require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase

	def setup
		@base_title = "Park 55 Medical Associates"
	end

  test "should http get the custom home page" do
    get :home
    assert_response :success
    assert_select "title", "#{@base_title}"
  end

end
