FROM node:20-slim
RUN apt-get update && apt-get install -y --no-install-recommends git ca-certificates unzip && rm -rf /var/lib/apt/lists/*
COPY *.zip /tmp/bot.zip
RUN unzip -q /tmp/bot.zip -d /tmp/x && mv /tmp/x/* /app && rm -rf /tmp/x /tmp/bot.zip
WORKDIR /app
RUN npm install --omit=dev
ENV DATA_DIR=/data
CMD ["node", "src/index.js"]
