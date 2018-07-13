FROM erlang
ADD . /emq-auth-http
WORKDIR /emq-auth-http
CMD [ "make" ]
