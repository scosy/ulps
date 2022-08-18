web: rails server -p ${PORT:-5000} -e $RAILS_ENV
worker: sidekiq -q default -q mailers -e $RAILS_ENV