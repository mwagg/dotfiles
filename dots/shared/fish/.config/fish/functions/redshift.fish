function redshift --no-scope-shadowing
    set port (random 10000 20000)
    ssh -f -o ExitOnForwardFailure=yes -L $port:redshift.eporta-internal:5439 bastion sleep 10
    set -x PGPASSWORD (aws ssm get-parameter --name "/prod/redshift/password" --with-decryption --output text | awk '{print $6}')
    psql -h localhost -p $port -U app_redshift analytics
end
