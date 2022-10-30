function stop_all_docker_containers {
    running_docker_count=$(docker ps -q | wc -l)

    if [ $running_docker_count -ne 0 ]; then
        docker stop $(docker ps -q)
    fi
}

function docker_clean_up {
    stop_all_docker_containers
    docker system prune --volumes -a -f
}
