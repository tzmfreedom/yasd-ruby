.PHONY: insert
insert:
	bundle exec exe/yasd insert -f examples/accounts.csv \
	  -c examples/config.rb \
	  -o Account \
	  -m examples/account.sdl.yml \
	  -C examples/account.cvt.rb

.PHONY: export
export:
	bundle exec exe/yasd export \
	  -c examples/config.yml \
	  -q "SELECT Id, Name FROM Message__c"

.PHONY: rubocop
rubocop:
	bundle exec rubocop -a

.PHONY: test
test:
	bundle exec rspec

.PHONY: build
build:
	docker build -t tzmfreedom/yasd .

.PHONY: release
release:
	bundle exec rake release
