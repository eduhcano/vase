# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_base_session',
  :secret      => '64ef787782c8d4f3609b3a9f1421107f52144db2d929a94a4f97eadf6f7c2995cbc0c4600cd9a3b1b2b9546f54000b12e137dd3ece88e2b1997daddf60b6d975'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
