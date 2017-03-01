Rails.application.config.session_store :redis_store,
                                       servers: ENV.fetch("REDIS_URL") { "redis://@localhost:6379" } + "/0/sessions",
                                       expires_in: 3.days
