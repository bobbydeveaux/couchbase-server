MAKEFLAGS += --silent
TEST?=./...

#########################   docker build
get-deps:
	@echo "==> Fetching dependencies"
	@go get -v -d $(TEST)

go-build-app:
	echo "Build GO Single Binary" ; \
	echo "##########################" ;\
	echo "CGO_ENABLED=0 GOOS=linux go build -o try-cb-golang ." ; \
	echo "##########################" ;\
	cd try-cb-golang/ && CGO_ENABLED=0 GOOS=linux go build -o try-cb-golang . 

ocp-new-build-cb: 
	echo "Create NEW EMPTY Build" ; \
	echo "##########################" ;\
	echo "oc new-build --name cb-demo --binary"
	echo "##########################" ;\
	oc new-build --name cb-demo --binary

ocp-start-build-cb: go-build-app
	echo "Build CB Container" ; \
	echo "##########################" ;\
	echo "oc start-build cb-demo --from-file=try-cb-golang/ --follow"
	echo "##########################" ;\
	oc start-build cb-demo --from-file=try-cb-golang/ --follow
	echo "can now tag is desired oc tag cb-demo:latest fe:x.y.z"

ocp-run-cb:
	echo "Run cb-demo image" ; \
	echo "##########################" ;\
	echo "oc new-app --name cb-demo --image-stream=cb-demo " ;\
	echo "##########################" ;\
	oc new-app --name cb-demo --image-stream=cb-demo 

go-build-beer:
	echo "Build GO Single Binary" ; \
	echo "##########################" ;\
	echo "CGO_ENABLED=0 GOOS=linux go build -o try-cb-golang ." ; \
	echo "##########################" ;\
	cd beersample-go/ && CGO_ENABLED=0 GOOS=linux go build -o beersample . 

ocp-new-build-beer: 
	echo "Create NEW EMPTY Build" ; \
	echo "##########################" ;\
	echo "oc new-build --name beer-demo --binary"
	echo "##########################" ;\
	oc new-build --name beer-demo --binary

ocp-start-build-beer: go-build-beer
	echo "Build CB Container" ; \
	echo "##########################" ;\
	echo "oc start-build beer-demo --from-file=beersample-go/ --follow"
	echo "##########################" ;\
	oc start-build beer-demo --from-file=beersample-go/ --follow
	echo "can now tag is desired oc tag beer-demo:latest fe:x.y.z"

ocp-run-beer:
	echo "Run beer-demo image" ; \
	echo "##########################" ;\
	echo "oc new-app --name cb-demo --image-stream=cb-demo " ;\
	echo "##########################" ;\
	oc new-app --name beer-demo --image-stream=beer-demo 
