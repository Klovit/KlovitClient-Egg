#! /bin/sh

cd /home/container || exit 1;

if [[ -f "/home/container/index.js" ]]; then
  node index.js
else
  echo "index.js not found. Proceed to install KlovitClient? (Y/N)";
  read proceed;

  case "$proceed" in
    "Y"|"y")
        echo "Installing KlovitClient...";

        git clone --branch stable https://github.com/Klovit/KlovitClient.git /home/container/KlovitClient
        mv /home/container/KlovitClient/** /home/container
        rm -rf /home/container/KlovitClient

        npm i > /dev/null 2>&1
        echo "KlovitClient is now downloaded. Please configure settings.json Manually or proceed with Automatic Configuration.";
        exit 0;
        ;;
    "N"|"n")
        exit 0;
        ;;
    *)
        exit 1;
        ;;
     echo "Do you want automatic Configuration of KlovitClient? (Y/N)";
     read autoconfig;
    case "$autoconfig" in
    "Y"|"y")
        echo "Installing KlovitClient...";

        read -p "What is the Host's Name? " name 
        read -p "What is the Icon's URL? " icon 
        read -p "What is the Host's Letter? " letter
        read -p "What is the Host's Discord Server's Link? " discord_srv
        read -p "What is the Host's Timezone? " timezone
        read -p "What is the Host's description? " description
        read -p "What is the KlovitClient's Port? " port
        read -p "What is the KlovitClient's Website Secret? " secret
        read -p "What is the Pterodactyl URL (With HTTPS)? " pterodactyl_url 
        read -p "What is the Pterodactyl API Key? " pterodactyl_api 
        read -p "What is the Ram's Store Limit? " ram_lmt 
        read -p "What is the Disk's Store Limit? " disk_lmt 
        read -p "What is the CPU's Store Limit? " cpu_lmt 
        read -p "What is the Servers' Store Limit? " server_lmt 
        read -p "What is the OAuth2 ID? " oauth2_id 
        read -p "What is the OAuth2 Secret? " oauth2_secret 
        read -p "What is the OAuth2 Redirect Link (Client's URL) " oauth2_redirect 
        read -p "What will be the Default RAM in MBs? " default_ram 
        read -p "What will be the Default Disk in MBs? " default_disk 
        read -p "What will be the Default CPU in %? " default_cpu
        read -p "What will be the Default Servers Limit? " default_servers
        read -p "What is the Location ID? " loc_id 
        read -p "What is the Location Name? " loc_name
        read -p "Do you want to enable Gifts (true/false)? " enablegifts 
        read -p "What will be the Store Price for RAM per GB? " ram_price 
        read -p "What will be the Store Price for Disk per GB? " disk_price 
        read -p "What will be the Store Price for CPU per Cores(100%)? " cpu_price 
        read -p "What will be the Store Price for Servers per Server? " servers_price 

        sed -i 's/  "name": "KlovitClient",/  "name": "${name}",/g' settings.json
        sed -i 's/  "letter": "K",/  "letter": "${letter}",/g' settings.json
        sed -i 's/  "icon": "",/  "icon": "${icon}",/g' settings.json
        sed -i 's/  "discord": "",/  "discord": "${discord_srv}",/g' settings.json
        sed -i 's/  "description": "The best modern Pterodactyl Client Area",/  "description": "${description}",/g' settings.json
        sed -i 's/  "timezone": "Asia/Kolkata",/  "timezone": "${timezone}",/g' settings.json
        sed -i 's/    "port": 8081,/    "port": ${port},/g' settings.json
        sed -i 's/    "secret": "Default Secret (Change this to any string you want)"/    "secret": "${secret}"/g' settings.json
        sed -i 's/    "domain": "https://panel.example.com",/    "domain": "${pterodactyl_url}",/g' settings.json
        sed -i 's/    "key": "Pterodactyl API Key"/    "key": "${pterodactyl_api}"/g' settings.json
        sed -i 's/  "storelimits": {
    "ram": "8192",
    "disk": "10240",
    "cpu": "400",
    "servers": "8"
  },/  "storelimits": {
    "ram": "${ram_lmt}",
    "disk": "${disk_lmt}",
    "cpu": "${cpu_lmt}",
    "servers": "${server_lmt}"
  },/g' settings.json
        sed -i 's/      "oauth2": {
        "_comment": "Go to https://discord.dev/ and create an application to set these up.",
        "id": "Oauth2 ID",
        "secret": "Oauth2 Secret",
        "link": "Oauth2 Redirect Link",/      "oauth2": {
        "_comment": "Go to https://discord.dev/ and create an application to set these up.",
        "id": "${oauth2_id}",
        "secret": "${oauth2_secret}",
        "link": "${oauth2_redirect}",/g' settings.json
        sed -i 's/        "list": {
          "default": {
            "ram": 1024,
            "disk": 1024,
            "cpu": 100,
            "servers": 1
          }/        "list": {
          "default": {
            "ram": ${default_ram},
            "disk": ${default_disk},
            "cpu": ${default_cpu},
            "servers": ${default_servers}
          }/g' settings.json
        sed -i 's/      "gift": {
        "enabled": false
      },/      "gift": {
        "enabled": ${enablegifts}
      },/g' settings.json
        sed -i 's/          "ram": {
            "cost": 100,
            "per": 1024
          },/          "ram": {
            "cost": ${ram_price},
            "per": 1024
          },/g' settings.json
        sed -i 's/          "disk": {
            "cost": 100,
            "per": 1024
          },/          "disk": {
            "cost": ${disk_price},
            "per": 1024
          },/g' settings.json
        sed -i 's/          "cpu": {
            "cost": 100,
            "per": 100
          },/          "cpu": {
            "cost": ${cpu_price},
            "per": 100
          },/g' settings.json
        sed -i 's/          "servers": {
            "cost": 100,
            "per": 1
          }/          "servers": {
            "cost": ${servers_price},
            "per": 1
          }/g' settings.json

        echo "KlovitClient is now installed.";
        exit 0;
        ;;
    "N"|"n")
        exit 0;
        ;;
    *)
        exit 1;
        ;;
    esac
fi
