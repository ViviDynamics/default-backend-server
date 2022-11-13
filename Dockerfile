FROM ruby:3.1.2

RUN apt-get update -qq && apt-get upgrade -y
WORKDIR /opt/default-backend-server
COPY ./ /opt/default-backend-server

SHELL ["/bin/bash", "--login", "-c"]
RUN echo "Install project dependencies" && \
    cd /opt/default-backend-server && \
    gem install bundler && \
    bundle install

RUN chmod +x /opt/default-backend-server/bin/entrypoint
COPY bin/entrypoint /usr/bin/
RUN chmod +x /usr/bin/entrypoint
ENTRYPOINT ["entrypoint"]
EXPOSE $PORT

CMD exec bundle exec rackup app.ru -o $BIND_ADDRESS -p $PORT
