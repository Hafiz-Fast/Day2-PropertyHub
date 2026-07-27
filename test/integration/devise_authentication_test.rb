require "test_helper"

class DeviseAuthenticationTest < ActionDispatch::IntegrationTest
  test "login and sign-up pages are available" do
    get new_user_session_path
    assert_response :success
    assert_select "h1", "Log in"

    get new_user_registration_path
    assert_response :success
    assert_select "h1", "Create account"
  end

  test "signing up stores an encrypted password" do
    assert_difference("User.count", 1) do
      post user_registration_path, params: {
        user: {
          name: "New Account",
          age: 30,
          email: "new-account@example.test",
          password: "secure-password",
          password_confirmation: "secure-password"
        }
      }
    end

    user = User.find_by!(email: "new-account@example.test")
    assert_equal 30, user.age
    assert user.encrypted_password.present?
    assert user.valid_password?("secure-password")
    assert_not_equal "secure-password", user.encrypted_password
  end
end
