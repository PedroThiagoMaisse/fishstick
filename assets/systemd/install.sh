#!/bin/bash


echo -e "   i: Setting vars"
REAL_USER=$(who | awk '{print $1}' | head -n1)
REAL_HOME=$(getent passwd "$REAL_USER" | cut -d: -f6)

        # echo -e "   i: Starting main.sh Setup"

        # sudo mkdir -p "$REAL_HOME/.local/bin/fishstick/"
        # sudo cp main.sh "$REAL_HOME/.local/bin/fishstick/cleanup.sh"

        # sudo chown "$USER:$USER" "$REAL_HOME/.local/bin/fishstick/cleanup.sh"
        # sudo chmod +x "$REAL_HOME/.local/bin/fishstick/cleanup.sh"

# echo -e "   i: Reloading Daemon"
# sudo systemctl daemon-reload



for i in $(find "./" -path "*/*/*"); do
    fileName=$(basename "$i")

    if [[ "$i" == *".service" ]]; then
        echo -e "   i: Starting .service Setup"
        sudo cp $i /etc/systemd/system/$fileName 
        sudo sed -i "s/#usr/$REAL_USER/g" /etc/systemd/system/$fileName

        sudo chown root:root /etc/systemd/system/$fileName
        sudo chmod 644 /etc/systemd/system/$fileName
    fi
    if [[ "$i" == *".timer" ]]; then
        echo -e "   i: Stopping timer"
        fileName=$(basename "$i")
        sudo systemctl stop "$fileName" 2>/dev/null

        echo -e "   i: Starting .timer Setup"
        sudo cp $i /etc/systemd/system/$fileName 

        sudo chown root:root /etc/systemd/system/$fileName
        sudo chmod 644 /etc/systemd/system/$fileName
    fi
done

for i in $(find "./" -path "*/*/*"); do
    fileName=$(basename "$i")
    
    if [[ "$i" == *".service" ]]; then
        echo "this is service final setup"
    fi
    if [[ "$i" == *".timer" ]]; then
        echo -e "   i: enabling and starting .timer"
        sudo systemctl enable fish-cleanup.timer
        sudo systemctl start fish-cleanup.timer
    fi
done