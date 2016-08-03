# sansapp

This cookbook contains can run a cluster with a nginx load-balancer and two backend servers. The cookbook is developed and run with Test Kitchen. The procedure to run the whole cluster is the following:

1. Start the first two backend servers.
2. Start the web node (nginx).
3. Run the rspec test with calls the load-balancer and checks if it is working in a round-robin fashion.

You can de-provision the cluster by running:

```bash
bundle exec kitchen destroy
```
The script to automate all the steps above is test.sh and it can be found in the root of this cookbook (a the same level of this file).

I had many issues to run three servers with Test Kitchen, the issue was a bug in Vagrant. Please check that you are running Vagrant 1.8.5.

Assumptions
-----------
I assume you are using OSX, with ChefDk (latest version) and Ruby 2.3.1.

Cookbook details
----------------
There are two recipes, one per each server type. IP numbers are setup in .kitchen.yml and the IPs are passed as Chef attributes to the cookbook to configure nginx. The Go code if fetched from another repository (git@github.com:rtacconi/sans_code.git) to make the cookbook a little bit more realistic.

A systemd init script controls the Go script which runs the 'Hello World' example.

Value are repeated over the cookbook and they should go in the attributes file (DRY), however due to time constraint I will leave as it is. I did not have the time to run Rubocop and Foodcritic.

The final test is run from the test.sh script and it is the following:

```bash
bundle exec rspec spec/load_balancer_spec.rb
```

To run the script it will take around six minutes. This is the output your should see in the end:

```bash
Running handlers:
Running handlers complete
Chef Client finished, 3/5 resources updated in 11 seconds
Finished converging <web-node-ubuntu-1604> (0m38.56s).
-----> Kitchen is finished. (2m55.30s)
.

Finished in 0.04342 seconds (files took 0.13737 seconds to load)
1 example, 0 failures
```
