NAME=nicklayb_nflrushing
IMAGE_TAG=nicklayb/nflrushing:latest
BUNDLE=/opt/rel/nfl_rushing/bin/nfl_rushing
PORTS=-p 4000:4000
DOCKERFILE=./dockerfiles/release.dockerfile

.PHONY: docker-build
docker-build:
	docker build -t $(IMAGE_TAG) -f $(DOCKERFILE) .

.PHONY: foreground
foreground: docker-build
	docker run $(PORTS) --name $(NAME) $(IMAGE_TAG)

.PHONY: background
background: docker-build
	docker run $(PORTS) --name $(NAME) -d $(IMAGE_TAG)

.PHONY: rebuild
rebuild:
	docker build -t $(IMAGE_TAG) -f $(DOCKERFILE) --no-cache .

.PHONY: kill
kill:
	docker stop $(NAME)
	docker rm $(NAME)

.PHONY: remote-console
remote-console:
	docker exec -it $(NAME) $(BUNDLE) remote

.PHONY: test
test:
	MIX_ENV=test mix test
