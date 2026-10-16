FROM node:20-slim
RUN apt-get update && apt-get install -y --no-install-recommends git ca-certificates unzip findutils && rm -rf /var/lib/apt/lists/*
COPY . /src
RUN set -e; \
    Z="$(ls -t /src/*.zip | head -n1)"; \
    mkdir /tmp/x; \
    unzip -q "$Z" -d /tmp/x; \
    D="$(find /tmp/x -name package.json -not -path '*/node_modules/*' -printf '%h\n' | head -n1)"; \
    test -n "$D"; \
    mv "$D" /app; \
    rm -rf /src /tmp/x
WORKDIR /app
RUN npm install --omit=dev
ENV NODE_ENV=production DATA_DIR=/data
CMD ["node", "src/index.js"]
