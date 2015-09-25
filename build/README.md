# Using fpm-cookery to build the RPM file

## NOTE: You need to replace the <version> field to the right version in all the places which was mentioned.  

Use the `Dockerfile` to build all the fpm-cookery environment, or just run the actual image: [fwynyk/fpm-cookery-aws-cli](https://hub.docker.com/r/fwynyk/fpm-cookery-aws-cli/)

You'll need open bash to run the fpm-cookery command. Don't forget to set all the right AWS credentials as ENV (option -e). The `docker run` command will be as follows:

	docker run -i -t \
	-e AWS_ACCESS_KEY_ID=<> \
	-e AWS_SECRET_ACCESS_KEY=<> \
	-e AWS_DEFAULT_REGION=<> \
	<image_id> \
	/bin/bash

Once inside the container, run:

	git clone https://github.com/moip/rpm-s3 --recurse-submodules

The next step will be create the tar.gz file and copy it to rpm-s3 bucket. It needs to be named with the right version of the final RPM. It will be used in `main.rb`. Here it is:

	tar -czvf rpm-s3-<version>.tar.gz rpm-s3
	aws s3 cp  rpm-s3-<version>.tar.gz s3://rpm-s3/rpm-s3-<version>.tar.gz --acl public-read-write	

Create the dir of the new version. You can copy the `main.rb` and the symblic link for the `files` dir from older versions.

	cd rpm-s3/build/
	mkdir rpm-s3/x.x.x

* OBS: Don't forget to set the right version of the package in `main.rb`. 

Now you can build the RPM:
	
	fpm-cook package -t rpm rpm-s3/<version>/main.rb


# TODO

* Check why post_install isn't working
