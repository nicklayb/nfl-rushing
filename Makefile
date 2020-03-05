NAME=nicklayb_nflrushing
IMAGE_TAG=nicklayb/nflrushing:latest
BUNDLE=/opt/rel/nfl_rushing/bin/nfl_rushing
PORTS=-p 4000:4000

.PHONY: docker-build
docker-build:
	docker build -t $(IMAGE_TAG) -f ./dockerfiles/release.dockerfile .

.PHONY: foreground
foreground: docker-build
	docker run $(PORTS) --name $(NAME) $(IMAGE_TAG)

.PHONY: background
background: docker-build
	docker run $(PORTS) --name $(NAME) -d $(IMAGE_TAG)

.PHONY: kill
kill:
	docker stop $(NAME)
	docker rm $(NAME)

.PHONY: remote-console
remote-console:
	docker exec -it $(NAME) $(BUNDLE) remote
