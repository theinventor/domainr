FactoryGirl.define do
  factory :identity_jane, :class => Identity do
    name "jane"
    email 'jane@doe.com'
    password "qwerty"
    password_confirmation "qwerty"
  end

  factory :identity_john, :class => Identity do
    name "john"
    email 'john@doe.com'
    password "qwerty"
    password_confirmation "qwerty"
  end

  factory :domain_google, :class => Domain do
    domain "google.com"
    user_id "1"
  end

  factory :domain_facebook, :class => Domain do
    domain "facebook.com"
    user_id "1"
  end

  factory :domain_twitter, :class => Domain do
    domain "twitter.com"
    user_id "1"
  end

#  factory :jane, :class => User do
#    full_name 'Jane Doe'
#    login 'janedoe'
#    email_work 'doe@jane.com'
#    password "jane1doe"
#    password_confirmation "jane1doe"
#  end

end