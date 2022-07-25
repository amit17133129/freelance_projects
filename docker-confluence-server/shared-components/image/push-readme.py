import logging
import os

import requests


logging.basicConfig(level=logging.INFO)


DOCKER_REPO = os.environ.get('DOCKER_REPO')
DOCKER_USERNAME = os.environ.get('DOCKER_USERNAME')
DOCKER_PASSWORD = os.environ.get('DOCKER_PASSWORD')
README_FILE = os.environ.get('README_FILE') or 'README.md'


logging.info('Generating Docker Hub JWT')
data = {'username': DOCKER_USERNAME, 'password': DOCKER_PASSWORD}
r = requests.post('https://hub.docker.com/v2/users/login/', json=data)
docker_token = r.json().get('token')

logging.info(f'Updating Docker Hub description for {DOCKER_REPO}')
with open(README_FILE) as f:
    full_description = f.read()
data = {'registry': 'registry-1.docker.io', 'full_description': full_description}
headers = {'Authorization': f'JWT {docker_token}'}
r = requests.patch(f'https://hub.docker.com/v2/repositories/{DOCKER_REPO}/',
                   json=data, headers=headers)

if r.status_code == requests.codes.ok:
    logging.info(f'Successfully updated {README_FILE} for {DOCKER_REPO}')
else:
    logging.info(f'Unable to update {README_FILE} for {DOCKER_REPO}, response code: {r.status_code}')
    r.raise_for_status()