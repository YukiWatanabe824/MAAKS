# frozen_string_literal: true

puts "\n== Seeding the database with fixtures ==" # rubocop:disable all
system('bin/rails db:fixtures:load')
