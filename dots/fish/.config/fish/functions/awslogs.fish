function awslogs
    set -l stream (aws logs describe-log-streams --log-group-name $argv[1] --order-by LastEventTime --descending --max-items 1 --output text --query 'logStreams[*].[logStreamName]' | head -n 1)
    aws logs get-log-events --log-group-name $argv[1] --log-stream-name $stream --output text --query 'events[*].[message]'
end
