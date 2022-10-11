include .env

default: dev

.PHONY: dev
.PHONY: deploy

dev: 
	iex -S mix

deploy:
	MIX_ENV=prod mix release
	_build/prod/rel/ada/bin/ada start