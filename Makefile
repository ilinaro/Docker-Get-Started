run: 
    docker run -d -p 80:3000 --name  yatapp --rm logsapp:exc
stop: 
    docker stop yatapp
