require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @user = users(:michael)
    @otheruser = users(:lana)
  end

  test "profile display" do
    get user_path(@user)
    assert_template 'users/show'
    assert_select 'title', full_title(@user.name)
    assert_select 'h1', text: @user.name
    assert_select 'h1>img.gravatar'
    assert_match @user.microposts.count.to_s, response.body
    assert_select 'div.pagination'
    @user.microposts.paginate(page: 1).each do |micropost|
      assert_match micropost.content, response.body
    end
  end

  test "profile stats" do
    get user_path(@user)
    assert_template 'users/show'
    assert_select '#following', @user.following.count.to_s
    assert_select '#followers', @user.followers.count.to_s
  end

  test "home profile stats" do
    get login_path
    post login_path, session: { email: @user.email, password: 'password' }
    assert is_logged_in?
    get root_path
    assert_template 'static_pages/home'
    assert_select '#following', @user.following.count.to_s
    assert_select '#followers', @user.followers.count.to_s
  end

end