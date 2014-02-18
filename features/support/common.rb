module CommonModule
  def password
    "weakest_password"
  end

  def create_user
    User.create!( :email => Faker::Internet.email,
      :password => password, :password_confirmation => password )
  end

  def create_user_from( complaint_title )
    name = grab_email_from( complaint_title )
    User.create( :email => name,
      :password => password, :password_confirmation => password )
  end

  def create_advocators( howmany = 5 )
    result = []

    (1..howmany).each do 
      result << self.create_user
    end

    result
  end

  def grab_email_from( complaint_title )
    email_from(complaint_title.split( " " ).first.downcase)
  end

  def email_from( name )
    "#{name.downcase}@domain.com"
  end
end

World( CommonModule )

Given /^'(.*)' is enrolled$/ do |name|
  User.create( :email => self.email_from(name),
    :password => self.password, 
    :password_confirmation => self.password
  )
end

And /^'(.*)' visits logging page$/ do |name| 
  visit( root_path )
  click_on('log_in')
end

Given /^'(.*)' signs in$/ do |name|
  step "'#{name}' visits logging page"

  fill_in( 'Email', :with => "#{name.downcase}@fenix.com" )
  fill_in( 'Password', :with => "weakest_password" )
  fill_in( 'Password confirmation', :with => "weakest_password" )
  click_on( 'Sign up' ) 
end

