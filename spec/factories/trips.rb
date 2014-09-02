# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :trip do
    name "MyString"
    notes "MyText"
    dest_lat 1.5
    dest_long 1.5
    depart_at "2014-08-28 11:42:54"
    arrive_at "2014-08-28 11:42:54"
    start_at "2014-08-28 11:42:54"
    finish_at "2014-08-28 11:42:54"
    authentication_token "MyString"
    pin 1
    user nil
  end
end
