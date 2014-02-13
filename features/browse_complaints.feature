Feature: Users can browse complaints list
  Users, even those who are neither logged in nor enrolled, can browse complaints

        Scenario: User access complaints list
          Given 'chad complaint' was written by author
          Given 'john complaint' was written by author
          When  User visit complaints
          Then  User sees 'chad complaint' and it's advocators
          And   User sees 'john complaint' and it's advocators
          
