
from iterators import TimeoutIterator
import re
import time
import xml.etree.ElementTree as etree

import requests
import testinfra


# Helper functions to get config values from support scripts
def get_app_home(container):
    cmd = "/bin/bash -c 'source /opt/atlassian/support/common.sh && get_app_home'"
    home = container.check_output(cmd)
    return home

def get_app_install_dir(container):
    cmd = "/bin/bash -c 'source /opt/atlassian/support/common.sh && get_app_install_dir'"
    home = container.check_output(cmd)
    return home

def get_bootstrap_proc(container):
    cmd = "/bin/bash -c 'source /opt/atlassian/support/common.sh && echo ${BOOTSTRAP_PROC}'"
    proc = container.check_output(cmd)
    return proc

# Run an image and wrap it in a TestInfra host for convenience.
# FIXME: There's probably a way to turn this into a fixture with parameters.
def run_image(docker_cli, image, **kwargs):
    container = docker_cli.containers.run(image, detach=True, **kwargs)
    return testinfra.get_host("docker://"+container.id)

# TestInfra's process command doesn't seem to work for arg matching
def get_procs(container):
    ps = container.run('ps -axo args')
    return ps.stdout.split('\n')

def parse_properties(container, properties):
    properties_raw = container.file(properties).content
    properties_str = properties_raw.decode().strip().split('\n')
    return dict(item.split("=") for item in properties_str)

def parse_xml(container, xml):
    return etree.fromstring(container.file(xml).content)

def wait_for_proc(container, proc_str, max_wait=10):
    waited = 0
    while waited < max_wait:
        procs = list(filter(lambda p: proc_str in p, get_procs(container)))
        if len(procs) > 0:
            return procs[0]
        time.sleep(0.1)
        waited += 0.1

    raise TimeoutError("Failed to find target process")

def wait_for_file(container, path, max_wait=10):
    waited = 0
    while waited < max_wait:
        if container.file(path).exists:
            return
        time.sleep(0.1)
        waited += 0.1

    raise TimeoutError("Failed to find target process")

def wait_for_http_response(url, expected_status=200, expected_state=None, max_wait=20):
    timeout = time.time() + max_wait
    while time.time() < timeout:
        try:
            r = requests.get(url)
        except requests.exceptions.ConnectionError:
            pass
        else:
            if r.status_code == expected_status:
                if expected_state is not None:
                    state = r.json().get('state')
                    assert state in expected_state
                return
        time.sleep(1)
    raise TimeoutError

def wait_for_state(url, expected_state, max_wait=300):
    timeout = time.time() + max_wait
    while time.time() < timeout:
        try:
            r = requests.get(url)
        except requests.exceptions.ConnectionError:
            pass
        else:
            try:
                # Ignore temporary errors
                state = r.json().get('state')
                if state == expected_state:
                    return
            except:
                pass
        time.sleep(1)
    raise TimeoutError

def wait_for_log(container, pattern, timeout=120):
    rpat = re.compile(pattern)
    logs = container.logs(stream=True, follow=True)
    li = TimeoutIterator(logs, timeout=timeout)
    for line in li:
        if line == li.get_sentinel():
            raise TimeoutError(f"Failed to find log line '{pattern}'")

        line = line.decode('UTF-8')
        if rpat.search(line):
            return line

    raise EOFError(f"Failed to find log line '{pattern}'")
