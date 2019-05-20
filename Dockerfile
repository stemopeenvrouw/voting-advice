FROM node:alpine
LABEL maintainer="Open State Foundation <developers@openstate.eu>" \
	  version="0.1.0" \
      description="Docker that fetches Google Sheet, processes the API output and builds a new version of the tool."
RUN apk add --no-cache \
	curl \
	jq \
&& mkdir -p app \
&& echo -e \
"@reboot /app/update.sh \$(cat /app/.google-sheets-id) \$(cat /app/.google-api-key)\n" \
"*/5 00-01,08-23 * * * /app/update.sh \$(cat /app/.google-sheets-id) \$(cat /app/.google-api-key)" > /etc/crontabs/root
# See https://crontab.guru/#*/5_00-01,08-23_*_*_*
WORKDIR /app
CMD ["crond", "-f"]
