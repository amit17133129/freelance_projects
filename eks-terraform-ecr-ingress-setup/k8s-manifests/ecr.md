```
aws ecr get-login-password --region region | docker login --username AWS --password-stdin aws_account_id.dkr.ecr.region.amazonaws.com

```

If your image repository doesn't exist in the registry you intend to push to yet, create it. For more information, see Creating a private repository.

Identify the local image to push. Run the docker images command to list the container images on your system.

```
docker images

```

Tag your image with the Amazon ECR registry, repository, and optional image tag name combination to use. The registry format is aws_account_id.dkr.ecr.region.amazonaws.com. The repository name should match the repository that you created for your image. If you omit the image tag, we assume that the tag is latest.

The following example tags a local image with the ID e9ae3c220b23 as aws_account_id.dkr.ecr.region.amazonaws.com/my-repository:tag.


```
docker tag e9ae3c220b23 aws_account_id.dkr.ecr.region.amazonaws.com/my-repository:tag

```

Push the image using the docker push command:

```
docker push aws_account_id.dkr.ecr.region.amazonaws.com/my-repository:tag

```