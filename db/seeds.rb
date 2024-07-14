# frozen_string_literal: true

puts "\n== Seeding the database with fixtures ==" # rubocop:disable all
system('rake db:fixtures:load FIXTURES_PATH=spec/fixtures')
