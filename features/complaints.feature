Feature: Users can browse complaints list
  Users, even those who are neither logged in nor enrolled, can browse complaints

        Scenario: User access complaints list
          Given 'chad complaint' and 'john complaint' were written by authors
          When  User visit 'complaints index'
          Then  User sees 'chad complaints' and it's advocators
          And   User sees 'john complaints' and it's advocators
          
