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
        ;
    esac
fi
