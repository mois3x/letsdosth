Feature: Users access to web page
  Users can sign up, log in to the web page

        Scenario: Not enrolled user signs in
          Given There is not users
          And   'John' clicked 'Sign Up'
          When  'John' sign up
          Then  'John' are logged in

        Scenario: Enrolled user can sign in
          Given 'John' is enrolled
          And   There not user logged in
          And   'John' visits logging page
          When  'John' signs in
          Then  'John' are logged in
          
