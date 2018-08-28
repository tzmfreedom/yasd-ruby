FROM ruby:2.5.1
ENV LANG C.UTF-8

RUN mkdir /myapp
WORKDIR /myapp

RUN gem install yasd

CMD ["bundle", "exec", "yasd", "-h"]