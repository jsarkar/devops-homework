# DOCKER TASKS
# Build the container
build-auth: ## Build the container
	docker build -t deepbluerun/auth:"$$(git rev-parse --short HEAD)" -f auth/Dockerfile auth ;\
	docker push deepbluerun/auth:"$$(git rev-parse --short HEAD)"

build-web: ## Build the container
	docker build -t deepbluerun/web:"$$(git rev-parse --short HEAD)" -f web/Dockerfile web ;\
	docker push deepbluerun/web:"$$(git rev-parse --short HEAD)"

    		
