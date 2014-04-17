# OmniAuth Redbooth.com

An official OmniAuth strategy for authenticating to Redbooth.com using OAuth2. To use it, you'll
need to have a Redbooth.com [developer account](https://redbooth.com/oauth_clients/).

## Installation

Add to your `Gemfile`:

```ruby
gem "omniauth-redbooth"
```

Then `bundle install`.

## Usage

Here's an example for adding the middleware to a Rails app in `config/initializers/omniauth.rb`:

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :redbooth, ENV['REDBOOTH_APP_ID'], ENV['REDBOOTH_APP_SECRET']
end
```

You can now access the OmniAuth Google OAuth2 URL: `/auth/redbooth`
