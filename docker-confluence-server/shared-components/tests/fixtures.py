import pytest

import os

import docker
import requests


DOCKERFILE = os.environ.get('DOCKERFILE') or 'Dockerfile'
DOCKERFILE_BUILDARGS = os.environ.get('DOCKERFILE_BUILDARGS')
DOCKERFILE_VERSION_ARG = os.environ.get('DOCKERFILE_VERSION_ARG')
MAC_PRODUCT_KEY = os.environ.get('MAC_PRODUCT_KEY') or 'docker-testapp'
APP_TEST_VERSION = os.environ.get('APP_TEST_VERSION') # Optional override


def parse_buildargs(buildargs):
    if buildargs is None or len(buildargs) == 0:
        return {}
    return dict(item.split("=") for item in buildargs.split(","))


def make_image():
    buildargs = parse_buildargs(DOCKERFILE_BUILDARGS)
    if APP_TEST_VERSION:
        buildargs[DOCKERFILE_VERSION_ARG] = APP_TEST_VERSION
    elif MAC_PRODUCT_KEY != 'docker-testapp':
        r = requests.get(f'https://marketplace.atlassian.com/rest/2/products/key/{MAC_PRODUCT_KEY}/versions/latest')
        version = r.json().get('name')
        buildargs[DOCKERFILE_VERSION_ARG] = version
    docker_cli = docker.from_env()
    tag = ''.join(ch for ch in DOCKERFILE if ch.isalnum())
    image = docker_cli.images.build(path='.',
                                    tag=f'{MAC_PRODUCT_KEY}:{tag}'.lower(),
                                    labels={"product_version": buildargs[DOCKERFILE_VERSION_ARG]},
                                    buildargs=buildargs,
                                    dockerfile=DOCKERFILE,
                                    rm=True)[0]
    return image


def get_run_user():
    i = make_image()
    image_env = {k:v for k,v in (x.split('=') for x in i.attrs['ContainerConfig']['Env'])}
    run_user = f'{image_env["RUN_UID"]}:{image_env["RUN_GID"]}'
    return run_user


# This fixture returns a temporary Docker CLI that cleans up running test containers after each test
@pytest.fixture
def docker_cli():
    docker_cli = docker.from_env()
    yield docker_cli
    for container in docker_cli.containers.list():
        for tag in container.image.tags:
            if tag.startswith(MAC_PRODUCT_KEY):
                container.remove(force=True)


# This fixture returns an image for the Docker build being tested
@pytest.fixture(scope='module')
def image():
    return make_image()


# This fixture returns the uid:gid for the Docker build being tested
@pytest.fixture(scope='module', params=['0:0', get_run_user()])
def run_user(request):
    return request.param
