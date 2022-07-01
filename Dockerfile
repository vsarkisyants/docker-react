#######################
# BUILD phase
#######################
FROM node:16-alpine as builder

USER node

RUN mkdir -p /home/node/app
WORKDIR /home/node/app

COPY --chown=node:node ./package.json ./
RUN npm install

# not necessary if using volumes (during development)
COPY --chown=node:node ./ ./

RUN npm run build

#######################
# RUN phase
#######################
FROM nginx

COPY --from=builder /home/node/app/build /usr/share/nginx/html