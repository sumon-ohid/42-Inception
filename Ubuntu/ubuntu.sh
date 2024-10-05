#!/bin/bash

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Set Zsh as the default shell by modifying /etc/passwd
sed -i 's|/bin/ash|/bin/zsh|' /etc/passwd


# Create a new user
useradd -m -s /bin/zsh -G sudo,adm $USERNAME

# Set the password for the user
echo "$USERNAME:$PASSWORD" | chpasswd

# Set the password for the root user
echo "root:$ROOT_PASSWORD" | chpasswd

exec "$@"
