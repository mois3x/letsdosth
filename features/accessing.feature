Feature: Users access to web page
  Users can sign up, log in to the web page

        Scenario: Not enrolled user signs in
          Given There is not users
          And   'John' clicked 'Sign Up'
          When  'John' sign up
          Then  'John' are logged in
