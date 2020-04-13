# hexo docker
Pull your hexo project Git code into a data volume and trigger automatic packaging via Webhook.

Webhook url: http://hostname:9000/hooks/hexo-webhook

##### [Docker hub image: funnyzak/hexo-docker](https://hub.docker.com/r/funnyzak/hexo)

---

## Available Configuration Parameters

The following flags are a list of all the currently supported options that can be changed by passing in the variables to docker with the -e flag.

 - **USE_HOOK** : The web hook is enabled as long as this is present.
 - **GIT_REPO** : URL to the repository containing your source code
 - **GIT_BRANCH** : Select a specific branch (optional)
 - **GIT_EMAIL** : Set your email for code pushing (required for git to work)
 - **GIT_NAME** : Set your name for code pushing (required for git to work)
 
## Volume

 - **/app/code** : hexo output dir.
 - **/app/output** : source code dir. Will automatically pull the code.
 - **/root/.ssh** :  If it is a private repository, please set ssh key


---

## Docker-Compose YAML
 ```
version: '3'
services:
  hexo_blog:
    image: funnyzak/hexo
    privileged: true
    container_name: hexo_blog
    working_dir: /app/hook
    logging:
      driver: 'json-file'
      options:
        max-size: '1g'
    tty: true
    environment:
      - USE_HOOK=1
      - GIT_REPO=git@github.com:username/repo_name.git
      - GIT_BRANCH=master
      - GIT_EMAIL=youremail
      - GIT_NAME=yourname
    restart: on-failure
    # 映射端口
    ports:
      - 9000:9000 # webhook port
    volumes:
      - ./output:/app/output # hexo output dir 
      - ./code:/app/code # source code dir. Will automatically pull the code.
      - ./ssh:/root/.ssh # If it is a private repository, please set ssh key

 ```
---

 ## Nginx Demo

 ```
server {
    listen       80;
    server_name  yourdomain.com;

    underscores_in_headers on;
    ssl off;

    location / {
        root   /mnt/app/hexo/output;
        index  index.html index.htm;
    }

    location /webhook {
        proxy_set_header Host $host;
        proxy_set_header X-Real-Ip $remote_addr;
        proxy_set_header X-Forwarded-For $remote_addr;
        proxy_pass http://127.0.0.1:9000/hooks/hexo-webhook;
    }

    error_page  404   /404.html;
}

 ```