STACK_NAME ?= ffmpeg-apm-layer
AWS_REGION ?= ap-southeast-1
CAPABILITIES ?= CAPABILITY_NAMED_IAM

.PHONY: clean
clean:
	rm -rf .aws-sam && rm -rf samconfig.toml && rm -rf build
.PHONY: build
build:
	make clean
	mkdir -p build/layer/bin
	cd build && curl https://johnvansickle.com/ffmpeg/releases/ffmpeg-release-amd64-static.tar.xz | tar x
	cd ..
	mv build/ffmpeg*/ffmpeg build/ffmpeg*/ffprobe build/layer/bin
	sam build
.PHONY: deploy
deploy:
	make build && sam deploy --region $(AWS_REGION) --stack-name $(STACK_NAME) --capabilities $(CAPABILITIES) --resolve-s3 --no-fail-on-empty-changeset --no-confirm-changeset