json.user do
    json.result @result
    json.user_id @user.id
    json.name @user.name
    json.email @user.email
    json.token @user.authentication_token
end