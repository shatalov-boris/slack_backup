# frozen_string_literal: true

Rails.application.config.session_store :redis_store,
                                       servers: ENV["REDIS_URL"] + "/0/sessions",
                                       expires_in: 6.months
