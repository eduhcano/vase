# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_base_session',
  :secret      => '93415416e732a56d9ffab6ddaa6ef5c7721978a37187a8eff29cecab32fc998dad47e564002d7c176e6fcc39851e2f0912898a142bd41ac7dfe3f5e078037368'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
