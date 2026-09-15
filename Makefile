# Ban Makefile tuong duong dev.ps1, dung khi ban o Git Bash / WSL / tren Pi.
.DEFAULT_GOAL := help
.PHONY: help up up-ot py cpp build down nuke ps fmt lint test

help: ## Liet ke lenh
	@grep -E '^[a-zA-Z_-]+:.*?## ' $(MAKEFILE_LIST) | awk 'BEGIN{FS=":.*?## "}{printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2}'

up:      ## Bat py + cpp
	docker compose up -d
up-ot:   ## Bat them mqtt + db + grafana
	docker compose --profile ot up -d
py:      ## Shell vao container Python
	docker compose exec py bash
cpp:     ## Shell vao container C++
	docker compose exec cpp bash
build:   ## Build lai image
	docker compose build
down:    ## Tat, giu volume
	docker compose --profile ot down
nuke:    ## Tat + xoa volume
	docker compose --profile ot down -v
ps:      ## Trang thai
	docker compose ps -a

fmt:     ## Format Python
	docker compose exec py black .
lint:    ## Lint Python
	docker compose exec py ruff check .
test:    ## Chay test Python
	docker compose exec py pytest -q
