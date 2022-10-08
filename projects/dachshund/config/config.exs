import Config

config :malamute,
  twilio_phone: System.get_env("TWILIO_PHONE")

config :ex_twilio,
  account_sid: {:system, "TWILIO_ACCOUNT_SID"},
  auth_token: {:system, "TWILIO_AUTH_TOKEN"}

config :malamute, Malamute.Email.Mailer,
  adapter: Bamboo.SMTPAdapter,
  server: "smtp.gmail.com",
  hostname: "smtp.gmail.com",
  port: 587,
  username: System.get_env("SMTP_USER"),
  password: System.get_env("SMTP_PASS"),
  tls: :if_available,
  allowed_tls_versions: [:tlsv1, :"tlsv1.1", :"tlsv1.2"],
  tls_log_level: :error,
  tls_verify: :verify,
  tls_cacertfile: "cert.pem",
  auth: :if_available,
  retries: 3

config :bamboo, :json_library, Poison
