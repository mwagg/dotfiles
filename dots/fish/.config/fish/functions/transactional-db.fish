function transactional-db --no-scope-shadowing
    set port (random 10000 20000)
    ssh -L $port:transactional-db.eporta-internal:5432 -f -o ExitOnForwardFailure=yes bastion sleep 10
    set -x PGPASSWORD (aws ssm get-parameter --name "/transactional/database/url" --with-decryption --output text | awk '{print $6}' | sed -e 's/postgres:\/\/transactional:\(.*\)@.*/\1/')
    psql -h localhost -p $port -U transactional transactional
end

