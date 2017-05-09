# image version can be seen here https://hub.docker.com/_/node/
FROM node:boron

RUN mkdir /code
WORKDIR /code

COPY . /code
RUN npm install

CMD [ "node", "app.js" ]
