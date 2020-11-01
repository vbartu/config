 #!/bin/bash

eval $(ssh-agent)
ssh-add ~/.ssh/id_rsa

 while true; do
    echo "try to connect..."
    ssh -N -o ServerAliveInterval=240 -R 43024:localhost:22 user@192.168.0.100
    echo "restarting in 5 seconds.."
    sleep 5
 done

