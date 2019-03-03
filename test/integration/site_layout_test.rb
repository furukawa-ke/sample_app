require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:michael)
  end
  
  test "layout links" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count:2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    get contact_path
    assert_select "title", full_title("Contact")
    
    # ログインしてない場合
    get users_path
    assert_redirected_to login_url
    get user_path(@user)
    assert_template 'users/show'
    get signup_path
    assert_template 'users/new'
    get edit_user_path(@user)
    assert_redirected_to login_url
    
    # ログイン済みの場合
    log_in_as(@user)
    get users_path
    assert_template 'users/index'
    get user_path(@user)
    assert_template 'users/show'
    get signup_path
    assert_template 'users/new'
    get edit_user_path(@user)
    assert_template 'users/edit'
  end
end
