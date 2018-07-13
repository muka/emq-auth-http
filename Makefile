PROJECT = emq_auth_http
PROJECT_DESCRIPTION = Authentication/ACL with HTTP API
PROJECT_VERSION = 2.3.10

DEPS = clique
dep_clique  = git https://github.com/emqtt/clique

BUILD_DEPS = emqttd cuttlefish
dep_emqttd = git https://github.com/emqtt/emqttd master
dep_cuttlefish = git https://github.com/emqtt/cuttlefish

ERLC_OPTS += +debug_info
ERLC_OPTS += +'{parse_transform, lager_transform}'

NO_AUTOPATCH = cuttlefish

TEST_DEPS = emqttc emq_retainer
dep_emqttc = git https://github.com/emqtt/emqttc.git master
dep_emq_retainer  = git https://github.com/emqtt/emq-retainer master

TEST_ERLC_OPTS += +debug_info
TEST_ERLC_OPTS += +'{parse_transform, lager_transform}'

COVER = true

build/docker:
	docker build . -t emq-auth-http:latest
	docker rmi emq-auth-http:latest

include erlang.mk

app:: rebar.config

app.config::
	./deps/cuttlefish/cuttlefish -l info -e etc/ -c etc/emq_auth_http.conf -i priv/emq_auth_http.schema -d data

