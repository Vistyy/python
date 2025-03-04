.PHONY: help
help: ## Show this help message
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: install
install: ## Install the project and dev dependencies
	poetry install

.PHONY: format
format: ## Format code using ruff
	poetry run ruff format .

.PHONY: lint
lint: ## Run ruff linter and try to fix issues
	poetry run ruff check --fix .

.PHONY: lint-check
lint-check: ## Run ruff linter without fixing
	poetry run ruff check .

.PHONY: type-check
type-check: ## Run mypy type checking
	poetry run mypy src/

.PHONY: security-check
security-check: ## Run security checks (bandit and safety)
	poetry run bandit -r src/
	poetry run safety check

.PHONY: test
test: ## Run tests with pytest
	poetry run pytest

.PHONY: test-cov
test-cov: ## Run tests with coverage report
	poetry run pytest --cov=src --cov-report=term-missing

.PHONY: check-all
check-all: format lint type-check security-check test-cov ## Run all checks (format, lint, type-check, security, tests)
