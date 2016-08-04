bundle exec kitchen converge app-node1-ubuntu-1604
bundle exec kitchen converge app-node2-ubuntu-1604
bundle exec kitchen converge web-node-ubuntu-1604
bundle exec rspec spec/load_balancer_spec.rb
