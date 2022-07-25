import pytest

from helpers import get_app_home, get_bootstrap_proc, run_image, wait_for_proc


def test_thread_dumps(docker_cli, image, run_user):
    COUNT = 3
    INTERVAL = 1
    container = run_image(docker_cli, image, user=run_user)
    wait_for_proc(container, get_bootstrap_proc(container))

    thread_cmd = f'/opt/atlassian/support/thread-dumps.sh --count {COUNT} --interval {INTERVAL}'
    container.run(thread_cmd)

    find_thread_cmd = f'find {get_app_home(container)} -name "*_THREADS.*.txt"'
    thread_dumps = container.run(find_thread_cmd).stdout.splitlines()
    assert len(thread_dumps) == COUNT

    find_top_cmd = f'find {get_app_home(container)} -name "*_CPU_USAGE.*.txt"'
    top_dumps = container.run(find_top_cmd).stdout.splitlines()
    assert len(top_dumps) == COUNT


def test_thread_dumps_no_top(docker_cli, image, run_user):
    COUNT = 3
    INTERVAL = 1
    container = run_image(docker_cli, image, user=run_user)
    wait_for_proc(container, get_bootstrap_proc(container))

    thread_cmd = f'/opt/atlassian/support/thread-dumps.sh --no-top --count {COUNT} --interval {INTERVAL}'
    container.run(thread_cmd)

    find_thread_cmd = f'find {get_app_home(container)} -name "*_THREADS.*.txt"'
    thread_dumps = container.run(find_thread_cmd).stdout.splitlines()
    assert len(thread_dumps) == COUNT

    find_top_cmd = f'find {get_app_home(container)} -name "*_CPU_USAGE.*.txt"'
    top_dumps = container.run(find_top_cmd).stdout.splitlines()
    assert len(top_dumps) == 0


def test_heap_dump(docker_cli, image, run_user):
    container = run_image(docker_cli, image, user=run_user)
    wait_for_proc(container, get_bootstrap_proc(container))

    heap_cmd = f'/opt/atlassian/support/heap-dump.sh'
    container.run(heap_cmd)

    ls_cmd = f'ls -la {get_app_home(container)}/heap.bin'
    heap_dump = container.run(ls_cmd).stdout.splitlines()
    assert len(heap_dump) == 1


def test_heap_dump_overwrite_false(docker_cli, image, run_user):
    container = run_image(docker_cli, image, user=run_user)
    wait_for_proc(container, get_bootstrap_proc(container))

    heap_cmd = f'/opt/atlassian/support/heap-dump.sh'
    ls_cmd = f'ls -la --time-style=full-iso {get_app_home(container)}/heap.bin'

    container.run(heap_cmd)
    heap_dump_1 = container.run(ls_cmd).stdout.splitlines()
    container.run(heap_cmd)
    heap_dump_2 = container.run(ls_cmd).stdout.splitlines()
    assert heap_dump_1 == heap_dump_2


def test_heap_dump_overwrite_true(docker_cli, image, run_user):
    container = run_image(docker_cli, image, user=run_user)
    wait_for_proc(container, get_bootstrap_proc(container))

    heap_cmd = f'/opt/atlassian/support/heap-dump.sh --force'
    ls_cmd = f'ls -la {get_app_home(container)}/heap.bin'

    container.run(heap_cmd)
    heap_dump_1 = container.run(ls_cmd).stdout.splitlines()
    container.run(heap_cmd)
    heap_dump_2 = container.run(ls_cmd).stdout.splitlines()
    assert heap_dump_1 != heap_dump_2


def test_app_name_set(docker_cli, image, run_user):
    container = run_image(docker_cli, image, user=run_user)
    wait_for_proc(container, get_bootstrap_proc(container))

    name = container.run('echo $APP_NAME').stdout.strip()

    assert name is not None and name != ""


def test_pidfile_set(docker_cli, image, run_user):
    container = run_image(docker_cli, image, user=run_user)
    wait_for_proc(container, get_bootstrap_proc(container))

    pidfile = f"{get_app_home(container)}/docker-app.pid"
    assert container.file(pidfile).exists

    pid = container.run(f"cat {pidfile}").stdout.strip()
    assert int(pid) > 1
