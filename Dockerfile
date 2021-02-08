# Stage 1
FROM node:10-alpine as build-step
RUN mkdir -p /app
WORKDIR /app
RUN npm install -g @angular/cli
COPY package.json /app
RUN npm install
COPY . /app
RUN ng build --aot

# Stage 2
FROM nginx:1.17.1-alpine
COPY --from=build-step /app/dist/ci-cd-sample-app /usr/share/nginx/html