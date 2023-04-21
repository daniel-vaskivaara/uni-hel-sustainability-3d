FROM debian:stable-slim

COPY PixelStreamingInfrastructure/Matchmaker /opt

WORKDIR /opt/platform_scripts/bash/
RUN apt update
RUN apt install -y curl
RUN chmod +x ./setup.sh && ./setup.sh
RUN chmod +x ./run.sh
ENTRYPOINT ./run.sh