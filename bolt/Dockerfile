FROM node:14

ENV RAILS_RTM_URL http://rails:3000/rtm

COPY . /app
WORKDIR /app
RUN npm install

CMD npm start