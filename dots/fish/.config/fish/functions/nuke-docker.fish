function nuke-docker
    docker ps -a --format "{{.ID}}" | xargs docker rm -vf
end
