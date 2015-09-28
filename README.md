# Motoboy

This small tool allows you to maintain YUM repositories of RPM packages on S3. The code is largely derived from [s3yum-updater](https://github.com/rockpack/s3yum-updater).

The advantage of this tool is that it doesn't need a full copy of the repo. Just give it the new package to add, and it will just update the repo metadata in the same S3 bucket as the RPM package. 

It also gives you a Dockerfile and a lambda function to build a queue/consumer solution. You can use them in AWS ECS and AWS Lambda.

## Requirements

1. Python installed (2.6+).

2. S3 credentials available in the `AWS_ACCESS_KEY` and `AWS_SECRET_KEY` environment variables:

        export AWS_ACCESS_KEY="key"
        export AWS_SECRET_KEY="secret"

3. You'll need to build the environment: ECS, Lambda, SQS and S3. You can use our Terraform recipes here: [motoboy](https://github.com/moip/recipes-non-pci/tree/master/terraform/aws/hybrid/services/motoboy)

## A raw installation and usage 

    git clone https://github.com/moip/motoboy --recurse-submodules

Let's say I want to add a `my-app-1.0.0.x86_64.rpm` package to a yum repo hosted in the `moip-packages-repository` S3 bucket, at the path `packages/noarch`:

    ./bin/rpm-s3 -b moip-packages-repository -p "packages/noarch" my-app-1.0.0.x86_64.rpm

OBS: The package needs to be in the motoboy root dir.

## A real installation and usage

The [installation and usage](https://github.com/moip/motoboy#installation) section above was described just to you know how it works. The [Dokerfile](https://github.com/moip/motoboy/blob/master/Dockerfile) and the [Lambda](https://github.com/moip/motoboy/tree/master/lambda) function abstract the raw mode above. You really would like to do this way.

OBS: Check if the docker image exists in Docker Hub. If not, just build an image called "moip/motoboy" and push it to Docker hub, using the [Dockerfile](https://github.com/moip/motoboy/blob/master/Dockerfile) provided here.


1. With the `Requirement 3` built, you can just put a new package into the S3 bucket `moip-packages-repository`. 

2. Just wait for the Lambda function do this magic. It will put a new SQS queue, starts a container in ECS to consume it and replace the repo metadata with the new package. It takes just a few seconds (genarally, 2~8s, depends of the size of the rpm) to do the trick. 

3. Now, configure the repo in the client:

    echo "[moip-packages-repository]
    name = Moip repo
    baseurl = https://s3.amazonaws.com/moip-packages-repository/packages/noarch" > /etc/yum.repos.d/moiprepo.repo

4. Install your app:

    yum install my-app

## Troubleshooting

### Requirements if you want to sign packages

Have a gnupg key ready in your keychain at `~/.gnupg`. You can list existing secret keys with `gpg --list-secret-keys`

Have a `~/.rpmmacros` file ready with the following content:

    %_signature gpg
    %_gpg_name Cyril Rohr # put the name of your key here

Pass the `--sign` option to `rpm-s3`:

    AWS_ACCESS_KEY="key" AWS_SECRET_KEY="secret" ./bin/rpm-s3 --sign my-app-1.0.0.x86_64.rpm

### Import gpg key to install signed packages

    sudo rpm --import path/to/public/key # this also accepts URLs

## TODO

* Release as python package.
* Add spec and control files for RPM and DEB packaging.
* More TODO's into the [build](https://github.com/moip/motoboy/tree/master/build) dir.
