function redshift --no-scope-shadowing
    ssh -f -o ExitOnForwardFailure=yes bastion sleep 10
    set -x PGPASSWORD (aws ssm get-parameter --name "/prod/redshift/password" --with-decryption --output text | awk '{print $6}')
    psql -h localhost -p 5439 -U app_redshift analytics
end
