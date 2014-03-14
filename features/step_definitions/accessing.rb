
def normalize_action( action = '' )
  action.downcase!.sub!(' ', '_')
end

Given "There is not users" do
  expect(User.all).to eq([])
end

And /^'(.*)' clicked '(.*)'$/ do |name, action|
  visit( root_path )
  click_on( normalize_action(action) )
end

And "There not user logged in" do
  visit( destroy_user_session_path )
end

When /^'(.+)' sign up$/ do |name|
  fill_in( 'Email', :with => "#{name.downcase}@fenix.com" )
  fill_in( 'Password', :with => "weakest_password" )
  fill_in( 'Password confirmation', :with => "weakest_password" )
  click_on( 'involve_myself' )
end

When /^'(.+)' are logged in$/ do |name|
  page.has_content?('Salir')
end

When /^'(.+)' clicks '(.+)'$/ do | name, link|
  click_link( 'do_you_forget_password' )
  fill_in( 'Email', :with => "#{self.email_from(name)}" )
  click_on( 'Send me reset password instructions' )
end

Then /^'(.+)' receives '(.*)'$/ do |name, mail_content| 
  mail = ActionMailer::Base.deliveries.last
  expect(mail.to).to include( self.email_from( name ) )
  expect(mail.subject).to have_content( mail_content )
end

Then /^'(.+)' clicks '(.*)' on mail$/ do |name, link| 
  mail = ActionMailer::Base.deliveries.last
  mail.body.click_on( link )
end
