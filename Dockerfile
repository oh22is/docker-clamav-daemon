# Choose the latest alpine image as the base image of this container
FROM alpine:latest

#Label stuff
LABEL maintainer="Lucas Pribbenow"
LABEL company="oh22information services GmbH"
LABEL version="1.2"
LABEL description="ClamAV Daemon running inside a Docker container"

# Switch to the root user for the next tasks
USER root

# Update the image and install required packages
RUN apk -U upgrade && \
    apk add --no-cache bash clamav rsyslog wget clamav-libunrar

# Copy the config file for the ClamAV Service and a startup script
COPY config /etc/clamav
COPY script/startup.sh /

# Create a run directory for ClamAV and set the right permissions
RUN mkdir /var/run/clamav && \
    chown clamav:clamav /var/run/clamav && \
    chmod 750 /var/run/clamav && \
    chown -R clamav:clamav startup.sh /etc/clamav && \
    chmod u+x startup.sh
	
# Expose the default port (3310) for the ClamAV daemon
EXPOSE 3310/tcp

# Switch to the ClamAV default user who needs to runs the startup script
USER clamav

# Execute the startup script
CMD ["/startup.sh"]