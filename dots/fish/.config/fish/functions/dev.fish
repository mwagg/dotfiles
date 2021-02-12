function dev
    podman pod create --name eporta -p 5432:5432 -p 9200:9200
    podman run -d -e POSTGRES_USER=app_user -e POSTGRES_DB=app_db -e POSTGRES_PASSWORD=foobar123 -p 5432:5432 postgres
    podman run -d \
        -e 'xpack.graph.enabled=false' \
        -e 'xpack.ml.enabled=false' \
        -e 'xpack.monitoring.enabled=false' \
        -e 'xpack.security.enabled=false' \
        -e 'xpack.watcher.enabled=false' \
        -e 'discovery.type=single-node' \
        -e 'ES_JAVA_OPTS=-Xms256m -Xmx1G' \
        docker.elastic.co/elasticsearch/elasticsearch:6.5.4
end
