<<<<<<< HEAD
# PHP project with Docker



### How to start
In order to start the project you need to start the container by running the following command:

    docker run --name it-academy-project -d \
        -p 88:80 \
        -p 8822:22 \
        --restart unless-stopped \
        amoraresco/it-academy-project:latest \

If you need to use your codebase inside this Docker container - you need to attach a volume to it with your code.
The command would look like this:

        docker run --name it-academy-project -d \
        -p 88:80 \
        -p 8822:22 \
        --restart unless-stopped \
        --volume /path/to/project/:/var/www/html \
        amoraresco/it-academy-project:latest \


You could create your script.sh that would rebuild the container. The content of it can be:

        #!/bin/bash

        echo "Stopping container.."
        docker stop it-academy-project

        echo "Removing container..."
        docker rm it-academy-project

        echo "Creating new container.."
        docker run --name it-academy-project -d \
                -p 88:80 \
                -p 8822:22 \
                --restart unless-stopped \
                --volume /home/containers/project/settings:/var/www/html/settings \
                amoraresco/it-academy-project:latest \


=======
My homework for Bootcamp


To load the project, please make a copy of .env.example and name it .env
Make sure to put valid credentials.
>>>>>>> 9233b0f51b337dceb2a792eaa9a18f7064e4fc0e
