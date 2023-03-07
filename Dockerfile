FROM node:14.1-alpine AS build-env
WORKDIR /app
COPY . .
RUN npm install 

ENV PATH="./node_modules/.bin:$PATH"
ARG api_ip=localhost:8081
ENV REACT_APP_API_IP=$api_ip

ARG auth_ip=localhost:8081
ENV REACT_APP_AUTH_IP=$auth_ip


COPY . ./
RUN npm run build

FROM nginx:1.17-alpine
RUN apk update && apk add ca-certificates nginx && rm -rf /var/cache/apk/*
RUN mkdir /run/nginx && touch /run/nginx/nginx.pid
WORKDIR /app
COPY --from=build-env /app/build /app
#COPY ./default.conf /etc/nginx/conf.d/default.conf
COPY ./default.conf /etc/nginx/conf.d/default.conf.template
COPY ./script.sh /script.sh
RUN chmod +x /script.sh
EXPOSE 80
CMD ["sh", "/script.sh"]
#CMD ["nginx", "-g", "daemon off;"]
