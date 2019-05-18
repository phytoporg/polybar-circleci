#!/bin/sh

#USER_PROJECT=$(git config --local remote.origin.url | sed -n 's#.*/\([^.]*\/[^.]*\)\.git#\1#p')
USER_PROJECT=phytoporg/circleci-template
echo $USER_PROJECT

JOBS=$(curl -u $TOKEN: "https://circleci.com/api/v1.1/project/github/$USER_PROJECT?limit=1&shallow=true")
echo $JOBS

# Here's the plan:
# If the fifo doesn't already exist, mkfifo $HOME/.polybar-circleci/fifo
# State is 'waiting for job'
# While true
#   If state is 'waiting for job':
#     Query jobs, limit=1
#     If the time is very recent (within 5 seconds), set state to 'querying job'
#   Else if state is 'querying job'
#     Write job query output to fifo
#     If the job state is failed or completed, break
#     Query jobs, limit=1, filter for id
