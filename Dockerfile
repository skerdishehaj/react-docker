# Stage 1: Build the application
FROM node:16-alpine AS builder
USER node
RUN mkdir -p /home/node/app
WORKDIR /home/node/app
COPY --chown=node:node ./package.json ./
RUN npm install
COPY --chown=node:node ./ ./
RUN npm run build

# Stage 2: Create the final image with Nginx
FROM nginx:latest
COPY --from=builder /home/node/app/build /usr/share/nginx/html
