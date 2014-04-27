FROM stackbrew/ubuntu:saucy
MAINTAINER Samuel Richardson <sam@richardson.co.nz>
EXPOSE 80

ENV APP_ROOT /var/www
ENV APP_NAME WebMProcessor

# add a deploy user
RUN useradd -d /home/deploy -m -s /bin/bash deploy

# create deploy folder
RUN mkdir -p /var/www && chown deploy:deploy /var/www

# add ssh keys
ADD .ssh /home/deploy/.ssh
RUN chmod -R 700 /home/deploy/.ssh && chown -R deploy:deploy /home/deploy/.ssh

# update aptitude
RUN apt-get -y update

# install git
RUN apt-get install -y git-core

# install mysql
RUN apt-get install -y libmysql-ruby libmysqlclient-dev

# install ruby 2.1.1 from source
RUN apt-get install -y curl zlib1g-dev build-essential libssl-dev libreadline6 libreadline6-dev libyaml-dev libxml2-dev libxslt1-dev wget dialog
RUN wget http://cache.ruby-lang.org/pub/ruby/2.1/ruby-2.1.1.tar.gz
RUN tar -xzvf ruby-2.1.1.tar.gz
RUN ./ruby-2.1.1/configure && make && make install
 
# ffmpeg install
RUN apt-get install -y libsdl1.2-dev zlib1g-dev libfaad-dev libgsm1-dev libtheora-dev libvorbis-dev libspeex-dev libopencore-amrwb-dev libopencore-amrnb-dev libxvidcore-dev libxvidcore4 libmp3lame-dev libjpeg62 libjpeg62-dev libvpx1
RUN apt-get install -y ffmpeg

# nginx install
RUN apt-get install -y nginx
RUN mkdir -p /var/log/nginx/ && chown -R deploy:deploy /var/log/nginx/

# all following commands as deploy user
USER deploy
ENV HOME /home/deploy
ENV GEM_HOME $HOME/.gems
ENV GEM_PATH $HOME/.gems
ENV PATH $GEM_PATH/bin:$PATH
ENV RAILS_ENV production

# install ssh and clone from github
RUN git clone git@github.com:Rodeoclash/WebMProcessor.git $APP_ROOT/$APP_NAME
 
# don't install rdocs by default
RUN echo "gem: --no-ri --no-rdoc" > /home/deploy/.gemrc

# install gems for project
RUN cd /var/www/WebMProcessor && gem install bundler
RUN bundle install --gemfile=$APP_ROOT/$APP_NAME/Gemfile

# start nginx
RUN nginx -c $APP_ROOT/$APP_NAME/config/nginx.conf

# start the foreman processes
