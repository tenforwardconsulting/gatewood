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

Once you have the docker-compose, you need to set up all the API keys and integrations. In a future version this will happen via the web app but for now you need to manually edit in some Basecamp and Slack tokens into the docker-compose file.  Once you're ready to go:

    docker-compose up -d

## Development

install `foreman` and run `forman start` which uses the `Procfile` to launch both the rails app and the js slack connector. Then you can edit the rails and js apps individually.
