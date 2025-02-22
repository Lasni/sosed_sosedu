# Default target
.DEFAULT_GOAL := run

# Run the Rails server
run:
	bundle exec rails server

# Precompile the assets and run
compile-run: precompile-assets run

# Clean run
clean-run:
	./bin/dev

# Precompile assets
precompile-assets:
	./bin/rails assets:precompile

# Run tests
test:
	bundle exec rspec

# Install dependencies
install:
	bundle install

# Clean up generated files
clean:
	rm -rf tmp/cache
	rm -rf log/*.log

# DB
db-migrate:
	bundle exec rake:db migrate

# Controllers
generate-controller:
	./bin/rails generate controller $(ARGS)

# Console
console:
	./bin/rails console

# Routes
show-routes:
	bundle exec rails routes