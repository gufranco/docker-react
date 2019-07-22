################################################################################
# Builder
################################################################################
# Latest LTS release
FROM node:10-alpine as builder

# Copy project, define workdir
COPY . /tmp
WORKDIR /tmp/app

# Build
RUN yarn global add create-react-app --ignore-optional && \
    yarn build

################################################################################
# Web server
################################################################################
# Latest stable release
FROM nginx:alpine

# Environment vars
ENV NODE_ENV production

# Copy artefact to container
COPY --from=builder ./tmp/app/build /usr/share/nginx/html
