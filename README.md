# Yasd

Yet Another Salesforce Dataloader

## Installation

```bash
$ gem install yasd
```

or 

```bash
$ docker run -it --rm tzmfreedom/yasd 
```
## Usage

Export
```bash
$ yasd export -q "SELECT id FROM Account"
```

Insert
```bash
$ yasd insert -f /path/to/insert.csv
```

Update
```bash
$ yasd update -f /path/to/update.csv
```

Upsert
```bash
$ yasd upsert -f /path/to/upsert.csv -k externalkey__c
```

Delete
```bash
$ yasd delete -f /path/to/delete.csv
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/yasd.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
