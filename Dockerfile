FROM node:16-alpine3.12 as build-step

RUN mkdir /app

WORKDIR /app

COPY package.json /app

RUN npm install

COPY . /app

RUN npm run build

FROM amazon/aws-cli
RUN mkdir /devops
WORKDIR /devops
COPY --from=build-step /app/build /devops
RUN aws s3 cp /devops s3://new --recursive
