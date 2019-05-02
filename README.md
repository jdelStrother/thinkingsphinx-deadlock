# README

Demo of deadlock in ThinkingSphinx.  The only interesting code is in application_controller.rb

* Prepare a database: `bin/rails db:create db:migrate`

* Start the server: `bin/rails s`

* Run `touch app/models/*; curl -s -o /dev/null localhost:3000/posts & curl -s -o /dev/null localhost:3000/posts` a few times until you (hopefully) reproduce the deadlock.  At this point you can view localhost:3000/rails/locks to see the deadlock

* After 15 seconds a timeout will kill the request

* Try switching to the ActiveSupport::Concurrency::LoadInterlockAwareMonitor mutex with `curl localhost:3000/posts?set_mutex=fixed`

* Run `touch app/models/*; curl -s -o /dev/null localhost:3000/posts & curl -s -o /dev/null localhost:3000/posts` a bunch of times.  Hopefully there'll be no deadlocks.
