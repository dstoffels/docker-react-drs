# **The build env**
FROM node:16-bullseye as build

WORKDIR /app

COPY package.json ./
COPY package-lock.json ./

RUN npm ci
RUN npm i react-scripts@4.0.3 -g

COPY ./ ./

RUN npm run build

FROM nginx:stable-alpine as prod

COPY --from=build /app/build /usr/share/nginx/html

EXPOSE 80

CMD [ "nginx", '-g', 'daemon off;' ]

