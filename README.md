# OmniAuth Redbooth Platform

An official OmniAuth strategy for authenticating with Redbooth Platform using OAuth2. To use it, you'll
need to have a Redbooth.com [developer account](http://developer.redbooth.com/).

# Getting Oauth credentials

First thing you need to do it's getting your own oauth app credentials. To do so please follow up the intructions given in the redbooth platform site

https://redbooth.com/api/getting-started/

# Examples

We provide you a sinatra example to test that everything works properly. If you want to make it run you just need to:

1. Clone this repo

```
git@github.com:teambox/omniauth-redbooth.git
cd omniauth-redbooth
```

2. Install dependencies

```
bundle install
```

3. Create an ouath app with `http://localhost:9292/auth/redbooth/callback` as one of the redirect uris.

4. Setup your credentials

```
export CLIENT_ID=_your_client_id_
export CLIENT_SECRET=_your_client_secret_
```

5. Run the sinatra instance

```
bundle exec rackup examples/config.ru
```

6. go live! http://localhost:9292


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

You can now access the URL: `/auth/redbooth`

# Auth Hash

Here's an example Auth Hash available in request.env['omniauth.auth']

```json
{
  "provider": "redbooth",
  "uid": 656485,
  "info": {
    "name": "Andrés Bravo",
    "email": "andres.bravo@redbooth.com"
  },
  "credentials": {
    "token": "b0e722c2c7a94f20de4blol439579ac06b26ed89a",
    "refresh_token": "36d4706cdf4efedlol6dde1dac1b637b7",
    "expires_at": 1409939217,
    "expires": true
  },
  "extra": {
    "raw_info": {
      "type": "User",
      "created_at": 1370420186,
      "updated_at": 1409904971,
      "id": 65642185,
      "first_name": "Andrés",
      "last_name": "Bravo",
      "email": "andres.bravo@redbooth.com",
      "needs_profile": false,
      "deleted": false,
      "bouncing_email": false,
      "confirmed_user": true,
      "username": "lol",
      "avatar_url": "https://secure.gravatar.com/avatar/5de4c7ba680c829033alolfd29?size=48&default=mm",
      "profile_avatar_url": "https://secure.gravatar.com/avatar/5de4c7ba680clolf86afd29?size=278&default=mm",
      "micro_avatar_url": "https://secure.gravatar.com/avatar/5de4c7ba68lol3ac0ed1f86afd29?size=24&default=mm",
      "first_day_of_week": "monday",
      "biography": "developer",
      "locale": "en",
      "time_zone": "Madrid",
      "default_digest": 4,
      "notify_conversations": false,
      "notify_tasks": false,
      "notify_pages": false,
      "default_watch_new_task": false,
      "default_watch_new_conversation": false,
      "default_watch_new_page": false,
      "digest_delivery_hour": 12,
      "wants_task_reminder": false,
      "rss_token": "30804ee9a4c59lol3179883b089c95",
      "calendar_token": "a86ba8c08f0lolf16513c9a52f9",
      "shortcut_apps": null,
      "project_activity_digest": "no_digest",
      "chat_token": "38bece53lol5f61532d",
      "do_not_disturb_at": null,
      "is_pro": true
    }
  }
}

```

# Token Expiry

The `access_token` expiration time the  its 7200 sec. After that you will need to perform refresh flow.

The `refresh_token` will be refreshed at the same time you ask for a new `access_token` remember to store it after the refresh token flow.

# License

Copyright (c) 2012 by Redbooth

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


