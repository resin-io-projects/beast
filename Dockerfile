FROM resin/%%RESIN_MACHINE_NAME%%-node

RUN apt-get update && apt-get -y install fbi imagemagick libcairo2-dev

RUN JOBS=MAX npm install --production --unsafe-perm && npm cache clean --force && rm -rf /tmp/*

COPY . /usr/src/app
WORKDIR /usr/src/app

CMD ./prestart.sh && ./start.sh
