# Okta - R&T Terraform Package


### Pre-requisites

Prior to running Terraform, setup a service account in Okta, elevate the permissions to a **Super Administrator**. Login using the service account into the Okta Admin Console, navigate to **Security** > **API** > **Tokens** and click on **Create Token** to generate a new API Token.

> **Note**\
> The API Token expires if idle for 30 days. Generate a new token if the current token has expired.

Every Okta tenant needs to have it's own github repository and the configurations on the repo can be updated based on requirements.

- Setup the following secrets on the vault for your runner

  - OKTA_API_TOKEN

- Setup the following variables:

  - OKTA_BASE_URL
  - OKTA_ORG_NAME


After applying the Terraform config, you will have to manually configure the following:

1. Okta Verify Authenticator Settings - Fastpass, Enrollment - Required with biometrics only, Number Challenge - All push challenges




