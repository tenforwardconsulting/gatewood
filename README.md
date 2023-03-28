# Grandma Gatewood
Blazing a better path to Basecamp.

## Integrations

Before Gatewood can do anything interesting, you need to set up a bunch of integrations.  These integrations allow gatewood to interact with these systems at a *global* level, not a project or team level.  You must set up an "app" to get this access to authorize your gatewood instace to then authenticate on behalf of a user.

### Basecamp
Visit: https://launchpad.37signals.com/integrations

After you click "new application" the next page is very straightforward.  The Only tricky thing is the "Redirect URI" which you should set to:

    https://<GATEWOOD_HOST>/auth/basecamp/callback

### Slack

Visit: https://api.slack.com/apps

Setting up a new slack app is more complicated than a basecamp app.

## Deploying

We recommend deploying via docker-compose.  Any cloud instance with docker installed should do:

    sudo apt-get update
    sudo apt-get install docker.io docker-compose

    mkdir gatewood && cd gatewood
    curl -O https://raw.githubusercontent.com/tenforwardconsulting/gatewood/main/docker-compose.yml
    curl -o https://raw.githubusercontent.com/tenforwardconsulting/gatewood/main/.env.example .env


Once you have the docker-compose, you need to set up all the API keys and integrations. In a future version this will happen via the web app but for now you need to manually edit in some Basecamp and Slack tokens into the [.env file.](https://raw.githubusercontent.com/tenforwardconsulting/gatewood/main/.env.example)  Once you're ready to go:

    docker-compose up -d

Then visit your deployed URL and it should prompt you to create the first adminstrator account.

## Config Variables

All configuration is done via environment variables. Configuration is stored in the main .env file (for production) and in bolt/.env and rails/config/application.yml during development.

## Development

install `foreman` and run `forman start` which uses the `Procfile` to launch both the rails app and the js slack connector. Then you can edit the rails and js apps individually. This will set all the local development environment variables to whatever is in the .env file in the project root.

If you want to run these services outside of foreman, you will need to create or symlink the .env file into rails/ and bolt/ respectively.

Since local testing relies heavily on oauth and other connected services, I use ngrok to develop and set GATEWOOD_HOST appropriately. You will also need to set up development versions of your intergration "apps" as well, see above.
