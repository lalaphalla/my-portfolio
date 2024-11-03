#!/bin/bash

# Restart Nginx
sudo systemctl restart nginx

# Keep Nginx running in the foreground
nginx -g "daemon off;"
