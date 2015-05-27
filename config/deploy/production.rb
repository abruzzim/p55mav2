puts "%PRODUCTION-I-TRACE, config/deploy/production.rb called."

# The server-based syntax can be used to override options:
# ------------------------------------
server 'www.p55ma.com',
  user: 'p55ma',
  roles: %w{web app db},
  ssh_options: {
    user: 'p55ma', # overrides user setting above
    keys: %w(/home/p55ma/.ssh/id_rsa),
    forward_agent: false,
    auth_methods: %w(publickey password)
    # password: 'please use keys'
  }
