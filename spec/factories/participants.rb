# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :participant do
    email "MyString"
    pin 1
    name "MyString"
    leader false
    current_lat 1.5
    current_long 1.5
    depart_at "2014-08-28 11:44:09"
    arrive_at "2014-08-28 11:44:09"
    join_at "2014-08-28 11:44:09"
    quit_at "2014-08-28 11:44:09"
    checkin_at "2014-08-28 11:44:09"
    status "MyString"
    trip nil
  end
end
