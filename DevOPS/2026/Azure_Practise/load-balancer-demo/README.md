# Two-node Nginx load-balancer demo

`node-1` shows a blue **Hello from Node 1** page; `node-2` shows a purple **Hello from Node 2** page. Deploy the matching folder to each backend VM.

From your bastion, replace the host names and SSH user, then copy each site to its intended node:

```bash
scp node-1/index.html azureuser@BACKEND_1:/tmp/index.html
scp node-2/index.html azureuser@BACKEND_2:/tmp/index.html
```

On each backend (via `ssh azureuser@BACKEND_1`, then repeat for `BACKEND_2`), install and configure Nginx:

```bash
sudo apt-get update && sudo apt-get install -y nginx
sudo mkdir -p /var/www/load-balancer-demo
sudo mv /tmp/index.html /var/www/load-balancer-demo/index.html
sudo tee /etc/nginx/sites-available/load-balancer-demo >/dev/null <<'EOF'
server {
    listen 80 default_server;
    listen [::]:80 default_server;
    server_name _;
    root /var/www/load-balancer-demo;
    index index.html;
    location / { try_files $uri $uri/ =404; }
}
EOF
sudo rm -f /etc/nginx/sites-enabled/default
sudo ln -sf /etc/nginx/sites-available/load-balancer-demo /etc/nginx/sites-enabled/load-balancer-demo
sudo nginx -t && sudo systemctl reload nginx
```

Use the load balancer frontend IP as the browser URL. To make round-robin changes easy to see, disable session persistence (sticky sessions) and refresh repeatedly. Ensure the load-balancer health probe can reach TCP port 80 on both backend VMs.
