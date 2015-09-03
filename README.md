# Unfollower 5000

Removes followers from your Twitter account.

## Installation

1. Add a new application to your Twitter account (or use an existing one)
2. Obtain the Authorization Token and Authorization Token Secret. The easiest way to do this is to use the Signature Generator found on documentation pages when signed in.
3. Clone this repository (`git clone git@github.com:stephenyeargin/unfollower5000.git`) to your computer.
4. Run `bundle install` within that directory. If you don't have bundler, see [their installation instructions]().
5. Copy `.env-dist` to `.env` and update the credentials from Step 2.
6. Run `rake help` to make sure everything works (you will receive instructions.)

## Usage

### `rake followers` or `rake followers[25]`

This generates a file called `assholes.txt` of your latest followers, depending on the number provided. Defaults to 100.

**Important:** After this file is created, edit and save it, removing legitimate followers. If you skip this step, you will block/report your friends. :flushed:

### `rake spam`

This will take the contents of `assholes.txt` and report each of them for spam. Note that the API appears to only accept 50 or so reports from users per day, so if you're reporting a lot of spam accounts, it will probably fail. In those cases, use `rake block`.

### `rake block`

Same as `rake spam` but it skips the "Report for Spam" API endpoint. There does not appear to be a limit to the number of followers (or non-followers) you can block through this method.
