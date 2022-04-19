# Must have `sentry-cli` installed globally
# Following variables must be passed in

SENTRY_AUTH_TOKEN=a4bf1a960e1d46a1a2938147038c9eecc9554d81b5374605861aae75cb6ecf84
SENTRY_ORG=ssi-hl
SENTRY_PROJECT=web-frontend

REACT_APP_RELEASE_VERSION=1.0.1

$(info    REACT_APP_RELEASE_VERSION is $(REACT_APP_RELEASE_VERSION))
$(info    SENTRY_ORG is $(SENTRY_ORG))
$(info    SENTRY_PROJECT is $(SENTRY_PROJECT))
$(info    SENTRY_AUTH_TOKEN is $(SENTRY_AUTH_TOKEN))


setup_release:
	sentry-cli --auth-token $(SENTRY_AUTH_TOKEN) releases  -o $(SENTRY_ORG) new -p $(SENTRY_PROJECT) $(REACT_APP_RELEASE_VERSION)
	sentry-cli --auth-token $(SENTRY_AUTH_TOKEN) releases  -o $(SENTRY_ORG) -p $(SENTRY_PROJECT) files $(REACT_APP_RELEASE_VERSION) \
        upload-sourcemaps --url-prefix "~/static/js" --validate build/static/js
	
	sentry-cli --auth-token $(SENTRY_AUTH_TOKEN) releases -o $(SENTRY_ORG) -p $(SENTRY_PROJECT) set-commits --auto $(REACT_APP_RELEASE_VERSION)	