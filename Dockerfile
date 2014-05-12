FROM stackbrew/ubuntu:saucy
MAINTAINER Samuel Richardson <sam@richardson.co.nz>
EXPOSE 80
EXPOSE 22

ENV APP_ROOT /var/www
ENV APP_NAME WebMProcessor
ENV APP_PATH $APP_ROOT/$APP_NAME

# add a deploy user
RUN useradd -d /home/deploy -m -s /bin/bash deploy

# create deploy folder and copy code
RUN mkdir -p $APP_PATH
ADD . $APP_PATH
RUN chown -R deploy:deploy $APP_PATH

# update aptitude
RUN apt-get -y update

# install git
RUN apt-get install -y git-core

# install mysql
RUN apt-get install -y libmysql-ruby libmysqlclient-dev

# install nginx and authbind to it can bind to port 80
RUN apt-get install -y nginx authbind
RUN touch /etc/authbind/byport/80
RUN chmod 500 /etc/authbind/byport/80
RUN chown deploy /etc/authbind/byport/80

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

# don't install rdocs by default
RUN echo "gem: --no-ri --no-rdoc" > /home/deploy/.gemrc

# install gems for project
RUN cd $APP_PATH && gem install bundler
RUN bundle install --gemfile $APP_PATH/Gemfile

# migrate database
# RUN cd $APP_PATH && foreman run -d /var/www/WebMProcessor -e /var/www/WebMProcessor/.env.production rake db:migrate

# return the foreman process command to start everything
CMD ["foreman", "start", "-d", "/var/www/WebMProcessor", "-f", "/var/www/WebMProcessor/Procfile.production", "-e", "/var/www/WebMProcessor/.env.production"]