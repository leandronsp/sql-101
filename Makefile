pg:
	@docker-compose run \
		--rm \
		--name postgres \
		--service-ports \
		postgres

join.network:
	@docker network create ${network} || true
	@docker network connect ${network} postgres
