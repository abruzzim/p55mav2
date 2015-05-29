puts "%STATIC_PAGES_CONTROLLER_TEST-I-TRACE, 'test/controllers/static_pages_controller_test.rb' called."

require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase

	def setup
		@base_title = "Park 55 Medical Associates"
    @logo_text = "Park 55 Medical"
  	get :home
	end

  test "expects http get request to be successful" do
    assert_response :success
  end

  test "expects custom title element to be correct" do
    assert_select "title" do
      assert_select "title", {count: 1}, "More than 1 title element"
      assert_select "title", {text: "#{@base_title}"}, "Incorrect title element text"
    end
  end

  test "expects home page to render correct template and layouts" do
    assert_template :home
    assert_template layout: "layouts/application", partial: "_shim"
    assert_template layout: "layouts/application", partial: "_header"
    assert_template layout: "layouts/application", partial: "_footer"
  end

  test "expects page to render correct bootstrap header styling" do
    assert_select "body" do
      assert_select "header" do
        assert_select "nav" do
          assert_select "nav.navbar.navbar-default.navbar-fixed-top"
          assert_select "div", {count: 3} do
            assert_select "div.container-fluid"

            assert_select "div" do
              assert_select "div.navbar-header" do
                assert_select "button" do
                  assert_select "button.navbar-toggle.collapsed"
                  assert_select ":match('type', ?)", /^button$/
                  assert_select ":match('data-toggle', ?)", /^collapse$/
                  assert_select ":match('data-target', ?)", /^#navbar-collapse-1$/
                  assert_select "span", {count: 4} do
                    assert_select "span.sr-only", {text: "Toggle Navigation"}
                    assert_select "span.icon-bar", {count: 3}
                  end
                end
                assert_select "a" do
                  assert_select "a.navbar-brand" do
                    assert_select "a.navbar-brand", {text: "#{@logo_text}"}, "-E-FATAL, Anchor tag text not #{@logo_text}"
                    assert_select ":match('href', ?)", /^\/$/, nil, "-E-FATAL, Root path not specified"
                  end
                end
              end
            end

            assert_select "div" do
              assert_select "div.collapse.navbar-collapse"
              assert_select ":match('id', ?)", /^navbar-collapse-1$/
              assert_select "ul" do
                assert_select "ul.nav.navbar-nav.navbar-right"

                assert_select "li", {count: 2} do

                  assert_select "li" do
                    assert_select "a" do
                      assert_select "a", {text: "Home"}
                      assert_select ":match('href', ?)", /^\/$/, nil, "-E-FATAL, Root path not specified"
                    end
                  end

                  assert_select "li" do
                    assert_select "a" do
                      assert_select "a", {text: "Sign In"}
                      assert_select ":match('href', ?)", /^\/signin$/, nil, "-E-FATAL, Sign in path not specified"
                    end
                  end

                end

              end
            end

          end
        end
      end
    end
  end

  test "expects page to render correct bootstrap body styling" do
    assert_select "body" do
      assert_select "div.container" do
      end
    end
  end

  test "expects page to render correct bootstrap footer text" do
    assert_select "body" do
      assert_select "footer" do
        assert_select "footer.footer" do
          assert_select "p>a" do
            assert_select "a", {text: "Framework Solutions, LLC"}
            assert_select ":match('href', ?)", /^https:\/\/www.framework-solutions.com$/
          end
        end
      end
    end
  end

  test "expects page to render correct bootstrap footer navbar links" do
    assert_select "body" do
      assert_select "footer" do
        assert_select "footer.footer" do
          assert_select "nav>ul>li>a", {count: 2} do
            assert_select "a", {text: "About"} do
              assert_select ":match('href', ?)", /^\/about$/, nil, "-E-FATAL, About path not specified"
            end
            assert_select "a", {text: "Help"} do
              assert_select ":match('href', ?)", /^\/help$/, nil, "-E-FATAL, Help path not specified"
            end            
          end
        end
      end
    end
  end

end # class

# Reference: https://github.com/rails/rails-dom-testing/blob/master/lib/rails/dom/testing/assertions/selector_assertions.rb
# Reference: http://edgeapi.rubyonrails.org/classes/ActionDispatch/Assertions/SelectorAssertions.html