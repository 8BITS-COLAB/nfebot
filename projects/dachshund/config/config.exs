import Config

config :ex_twilio,
  account_sid: System.get_env("TWILIO_ACCOUNT_SID"),
  auth_token: System.get_env("TWILIO_AUTH_TOKEN")

config :ada, ADA.Assistant,
  url: System.get_env("ASSISTANT_URL"),
  apikey: System.get_env("ASSISTANT_APIKEY"),
  id: System.get_env("ASSISTANT_ID"),
  version: System.get_env("ASSISTANT_VERSION")

config :ada, ADA.Email.Sender,
  adapter: Bamboo.SMTPAdapter,
  server: "smtp.gmail.com",
  hostname: "smt.gmail.com",
  port: 587,
  username: System.get_env("SMTP_USER"),
  password: System.get_env("SMTP_PASS"),
  tls: :if_available,
  allowed_tls_versions: [:tlsv1, :"tlsv1.1", :"tlsv1.2"],
  tls_log_level: :error,
  tls_verify: :verify,
  tls_cacertfile: "cert.pem",
  retries: 3,
  auth: :if_available
