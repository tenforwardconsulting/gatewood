# Grandma Gatewood
Blazing a better path to Basecamp.

## Integrations

Before Gatewood can do anything interesting, you need to set up a bunch of integrations.

Basecamp: https://launchpad.37signals.com/integrations

## Deploying

We recommend deploying via docker-compose.  Any cloud instance with docker installed should do:

    sudo apt-get update
    sudo apt-get install docker.io docker-compose

    mkdir gatewood && cd gatewood
    curl -O https://raw.githubusercontent.com/tenforwardconsulting/gatewood/main/docker-compose.yml

Once you have the docker-compose, you need to set up all the API keys and integrations. In a future version this will happen via the web app but for now you need to manually edit in some Basecamp and Slack tokens into the (.env file.)[]  Once you're ready to go:

    docker-compose up -d

## Config Variables

All configuration is done via environment variables. Configuration is stored in the main .env file (for production) and in bolt/.env and rails/config/application.yml during development.

    # Shared configuration
    GATEWOOD_HOST="https://gatewood.example.com"

    # Rails / Basecamp secrets
    BASECAMP_CLIENT_ID: a463ab66c4af430b1e481f8cff5bd5a5bca3b96a
    BASECAMP_CLIENT_SECRET: 872e54b6533b57e480d4dbc33f67b91e40dbb26c
    BASECAMP_TEAM: "3439565"
    SLACK_TEAM: "tenforward"

    # Bolt / Slack secrets
    SLACK_SIGNING_SECRET=
    SLACK_BOT_TOKEN=
    SLACK_APP_TOKEN=
    SLACK_TEAM=
## Development

install `foreman` and run `forman start` which uses the `Procfile` to launch both the rails app and the js slack connector. Then you can edit the rails and js apps individually.
