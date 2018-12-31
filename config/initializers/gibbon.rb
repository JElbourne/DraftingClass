Gibbon::Request.api_key = Rails.application.credentials.MAILCHIMP_API_KEY
Gibbon::Request.timeout = 15
Gibbon::Request.open_timeout = 15
Gibbon::Request.symbolize_keys = true
Gibbon::Request.debug = false