.PHONY: insert
insert:
	bundle exec exe/yasd insert -f examples/accounts.csv \
	  -c examples/config.rb \
	  -o Account \
	  -m examples/account.sdl.yml \
	  -C examples/account.cvt.rb

.PHONY: load
load:
	bundle exec exe/yasd load -f examples/accounts.csv -c examples/config.rb -q "SELECT Id, Name FROM Message__c"

.PHONY: rubocop
rubocop:
	bundle exec rubocop -a

.PHONY: test
test:
	bundle exec rspec
