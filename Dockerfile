FROM stackbrew/ubuntu:saucy
MAINTAINER Samuel Richardson <sam@richardson.co.nz>
EXPOSE 80

ENV APP_ROOT /var/www
ENV APP_NAME WebMProcessor
ENV APP_PATH $APP_ROOT/$APP_NAME

# add a deploy user
RUN useradd -d /home/deploy -m -s /bin/bash deploy

# create deploy folder
RUN mkdir -p $APP_PATH && chown deploy:deploy $APP_PATH

# update aptitude
RUN apt-get -y update

# install git
RUN apt-get install -y git-core

# install mysql
RUN apt-get install -y libmysql-ruby libmysqlclient-dev

# install nginx
RUN apt-get install -y nginx

# redirect port 80 to port 8000 for nginx
iptables -A PREROUTING -t nat -i eth0 -p tcp --dport 80 -j REDIRECT --to-port 8000

# setup nginx folders
RUN mkdir -p /var/lib/nginx && chown deploy:deploy /var/lib/nginx
RUN mkdir -p /var/log/nginx && chown deploy:deploy /var/log/nginx

# install ruby 2.1.1 from source
RUN apt-get install -y curl zlib1g-dev build-essential libssl-dev libreadline6 libreadline6-dev libyaml-dev libxml2-dev libxslt1-dev wget dialog
RUN wget http://cache.ruby-lang.org/pub/ruby/2.1/ruby-2.1.1.tar.gz
RUN tar -xzvf ruby-2.1.1.tar.gz
RUN ./ruby-2.1.1/configure && make && make install
 
# ffmpeg install
RUN apt-get install -y libsdl1.2-dev zlib1g-dev libfaad-dev libgsm1-dev libtheora-dev libvorbis-dev libspeex-dev libopencore-amrwb-dev libopencore-amrnb-dev libxvidcore-dev libxvidcore4 libmp3lame-dev libjpeg62 libjpeg62-dev libvpx1
RUN apt-get install -y ffmpeg

# all following commands as deploy user
USER deploy
ENV HOME /home/deploy
ENV GEM_HOME $HOME/.gems
ENV GEM_PATH $HOME/.gems
ENV PATH $GEM_PATH/bin:$PATH
ENV RAILS_ENV production

# [TEMP] set env variables
# ========================
ENV MIN_FRAME_RATE 10
ENV MAX_FRAME_RATE 300
ENV MIN_BIT_RATE 100
ENV MAX_BIT_RATE 5000
ENV MIN_BUFFER_SIZE 100
ENV MAX_BUFFER_SIZE 5000
ENV MIN_BIT_RATE_TOLERANCE 100
ENV MAX_BIT_RATE_TOLERANCE 5000
ENV MIN_KEYFRAME_INTERVAL 100
ENV MAX_KEYFRAME_INTERVAL 500
ENV MIN_DURATION 1
ENV MAX_DURATION 12
ENV MIN_FILESIZE 102400
ENV MAX_FILESIZE 209715200

ENV DEVELOPMENT_DATABASE_NAME WebMProcessor_development
ENV DEVELOPMENT_DATABASE_USER root
ENV DEVELOPMENT_DATABASE_HOST localhost

ENV TEST_DATABASE_NAME WebMProcessor_test
ENV TEST_DATABASE_USER root
ENV TEST_DATABASE_HOST localhost

ENV PRODUCTION_DATABASE_NAME WebMProcessor_production
ENV PRODUCTION_DATABASE_USER root
ENV PRODUCTION_DATABASE_HOST 192.168.0.7

ENV FIREBASE_URI https://webmprocessor.firebaseio.com
ENV FIREBASE_KEY XNOZwXBLv3mficZE1IMYog3WUCHBJhhIeLsHHwEy

ENV AWS_ACCESS_KEY_ID AKIAJ7CHP6V5RACW4WLQ
ENV AWS_SECRET_ACCESS_KEY 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
ENV AWS_BUCKET webm-convertor

ENV REDIS_URL redis://locahost:6379
# ========================

# don't install rdocs by default
RUN echo "gem: --no-ri --no-rdoc" > /home/deploy/.gemrc

# copy over code
ADD . $APP_PATH

# setup tmp folders
#RUN mkdir -p $APP_PATH/tmp/pids
#RUN mkdir -p $APP_PATH/tmp/sockets
#RUN mkdir -p $APP_PATH/tmp/logs

# install gems for project
RUN cd $APP_PATH && gem install bundler
RUN bundle install --gemfile=$APP_PATH/Gemfile

# migrate database
RUN cd $APP_PATH && rake db:migrate

# return the foreman process command to start everything
CMD ["foreman", "start", "-d", "$APP_PATH"]
