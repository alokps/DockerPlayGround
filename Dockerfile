# as here ensures this is a build step inside the dockerfile everthing under
# this is considered as a part of this build step
FROM node:16-alpine as builder

WORKDIR '/app'

COPY package.json .

RUN npm install

COPY . .

RUN npm run build

# Second base Image

FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html
# default command of nginx is to startup the nginx, so we dont need to specify it