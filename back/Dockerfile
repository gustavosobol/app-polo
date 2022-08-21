FROM node:18.7-alpine3.16
ENV NODE_ENV=production

RUN apk add tzdata
RUN cp /usr/share/zoneinfo/America/Argentina/Ushuaia /etc/localtime
RUN echo "America/Argentina/Ushuaia" >  /etc/timezone

RUN mkdir /back
WORKDIR /back

RUN npm i -g nodemon

EXPOSE ${PORT}

CMD ["npm", "start"]