pg:
	@docker-compose run \
		--rm \
		--name postgres \
		--service-ports \
		postgres
