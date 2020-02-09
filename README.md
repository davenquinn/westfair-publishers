# https://github.com/skydiver/now-mailgun-sender/blob/master/index.js

now secrets add mailgun_api_key "YOU_MAILGUN_API_KEY"
now secrets add mailgun_domain "YOUR_MAILGUN_DOMAIN"
now secrets add mailgun_recipient "YOUR_EMAIL_ADDRESS"
now secrets add mailgun_sender "NOREPLY_ADDRESS"

Run with `now dev`
