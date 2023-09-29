# shellcheck disable=SC2148
function __docker_containers_ids {
    docker ps -q
}

function __docker_are_there_containers_running {
    running_containers="$(__docker_containers_ids)"

    if [[ -n "${running_containers}" ]]; then
        return 0
    fi
    return 1
}

function __docker_stop_containers {
    if __docker_are_there_containers_running; then
        docker stop "$(__docker_containers_ids)"
    fi
}

function docker-full-clean {
    __docker_stop_containers
    docker system prune --volumes -a -f
}
