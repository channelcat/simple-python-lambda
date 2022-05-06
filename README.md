# Simple Python Lambda

Sometimes you want to make a simple python lambda and don't want to have to set up local development tools and libraries, or deal with virtual environments.  Things can get more complicated when you want to add in python packages, requiring layers.  This package provides an opinionated setup that gives you the following features:

 * Basic API gateway lambda
 * Local testing web server
 * Hot reloading
 * Python package installation via `requirements.txt`
 * Auto-deploy via push to source control
 * Dockerized local development

## Local Setup / Running
 * Install Docker ([Docker Desktop](https://docs.docker.com/desktop/) Recommended)
 * `docker-compose up`
 * That's it!  Open or `curl` http://localhost:3000/prod

## Deploying:
 The project will automatically deploy when changes are pushed to the `main` branch via github actions, provided secrets are set up
 * In Github, for the project, go to `Settings` -> `Secrets` -> `Actions`
 * Add `AWS_SECRET_KEY_ID` and `AWS_SECRET_ACCESS_KEY`
 * Commit any changes to `main` and watch the magic happen!
 * Check the output of the action for the resulting lambda URL

## Installing packages:
 Pakcages are installed into the `lib` folder in lambda, and get shipped when deploying.  They are contained in the docker image upon building.  To add packages, simply:
 * Add package names to `lambda/requirements.txt`
 * `docker-compose build`

## Adding Endpoints:
 * In `lambda/serverless.yml`, under `functions:`, add a new endpoint.  Example:
```yml
  other_handler:
    handler: lambda_function.other_handler
    events:
      - http:
          path: /other
          method: post
```
 * Add a new handler functions in `lambda_handler.py`.  Example:
```python
def other_handler(event, context):
    body = json.loads(event['body'])
    return {
        'statusCode': 200,
        'body': json.dumps({"received": body.get('posted')})
    }
```
 * Try it out with `curl -d '{"posted": "toasted"}' http://localhost:3000/prod`


## Deploying Locally:
 Though the project can auto-deploy on commit to `main`, maybe you want to test it locally.
 * Setup `AWS_SECRET_KEY_ID` and `AWS_SECRET_ACCESS_KEY` environment variables in your local shell.  They will automatically be transferred to the container instance when running.
 * run `docker-compose run --rm lambda serverless deploy`

## Testing Lambda??
 * `curl -d '{}' http://localhost:3002/2015-03-31/functions/tiktok-promo-approval-prod-lambda_handler/invocations`
