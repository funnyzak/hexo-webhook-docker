# hexo docker
Pull your Git code into a data volume ready to use in other containers. Provides a webhook, so that you can get new code pulled in automatically.

Webhook url: http://hostname:9000/hooks/hexo-webhook

##### [Docker hub image: funnyzak/hexo-docker](https://hub.docker.com/r/funnyzak/hexo)


## Available Configuration Parameters

The following flags are a list of all the currently supported options that can be changed by passing in the variables to docker with the -e flag.

 - **GIT_REPO** : URL to the repository containing your source code
 - **GIT_BRANCH** : Select a specific branch (optional)
 - **GIT_EMAIL** : Set your email for code pushing (required for git to work)
 - **GIT_NAME** : Set your name for code pushing (required for git to work)
 
 ## Docker-Compose Yaml

 ```
version: '3'
services:
  pblog:
    image: hexo
    privileged: true
    container_name: pblog
    working_dir: /app/hook
    logging:
      driver: 'json-file'
      options:
        max-size: '1g'
    tty: true
    environment:
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
      - ./code:/app/code # source code dir
      - ./ssh:/root/.ssh # If it is a private repository, please set ssh key

 ```