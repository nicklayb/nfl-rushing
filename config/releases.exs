import Config

config :nfl_rushing, NflRushingWeb.Endpoint,
  http: [:inet6, port: System.get_env("PORT") || 4000],
  url: [host: "example.com", port: 80],
  cache_static_manifest: "priv/static/cache_manifest.json",
  secret_key_base: "utN6PSLDSvOEcQxJVOpqsklX6HsSxjFik9XwQGTU4/by0xcEHdmdPugkwzeMHCuD",
  server: true
