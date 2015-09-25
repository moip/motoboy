# Using fpm-cockery to build the RPM file

Use the `Dockerfile` to build all the fpm-cookery environment, or just run the actual image: 
	
	fwynyk/fpm-cookery-aws-cli

Don't forget to set all the right AWS credentials as ENV (option -e). The `docker run` command will be as follows:

	docker run -i -t \
	-e AWS_ACCESS_KEY_ID=<> \
	-e AWS_SECRET_ACCESS_KEY=<> \
	-e AWS_DEFAULT_REGION=<> \
	<image_id> \
	/bin/bash

# TODO

* Check why post_install isn't working
