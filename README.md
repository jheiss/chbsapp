# chbs

A web UI implementation of the xkcd
[correct horse battery staple](https://xkcd.com/936/) password generator.

I.e. pick four random, common words and string them together to make a very
strong but easy to remember password.

The default corpus (word list) contains the most common words in TV and movie
scripts. A corpus of the most common words from Project Gutenberg is also
included, if you want your passwords to have a bit more of an old-timey feel.

A working installation can be found at https://chbs.app/

See https://github.com/jheiss/chbs for the corresponding library and command line client.

## Running in development

* Clone this repo
* Run `bundle`
* ruby chbsapp.rb

## Running in production

There are many ways to deploy a production Sinatra app, here's one:

* Clone this repo
* Run `bundle install --with production`
* Run `bundle exec unicorn -E production`

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
