> Not maintained anymore, please visit new Docker. [Here](https://github.com/funnyzak/git-webhook-deploy-docker)


# Hexo Webhook Docker

Pull your hexo project Git code into a data volume and trigger automatic packaging via Webhook.

[![Docker Stars](https://img.shields.io/docker/stars/funnyzak/hexo-webhook.svg?style=flat-square)](https://hub.docker.com/r/funnyzak/hexo-webhook/)
[![Docker Pulls](https://img.shields.io/docker/pulls/funnyzak/hexo-webhook.svg?style=flat-square)](https://hub.docker.com/r/funnyzak/hexo-webhook/)

This image is based on Alpine Linux image, which is a 163MB image.

Download size of this image is:

[![](https://images.microbadger.com/badges/image/funnyzak/hexo-webhook.svg)](http://microbadger.com/images/funnyzak/hexo-webhook)

[Docker hub image: funnyzak/hexo-webhook](https://hub.docker.com/r/funnyzak/hexo-webhook)

Docker Pull Command: `docker pull funnyzak/hexo-webhook`

Visit Url: [http://hostname:80/](#)

Webhook Url: [http://hostname:80/hooks/git-webhook?token=HOOK_TOKEN](#)

---

## Available Configuration Parameters

The following flags are a list of all the currently supported options that can be changed by passing in the variables to docker with the -e flag.

* **USE_HOOK** : The web hook is enabled as long as this is present.
* **HOOK_TOKEN** : Custom hook security tokens, strings.
* **GIT_REPO** : URL to the repository containing your source code
* **GIT_BRANCH** : Select a specific branch (optional)
* **GIT_EMAIL** : Set your email for code pushing (required for git to work)
* **GIT_NAME** : Set your name for code pushing (required for git to work)
* **NOTIFY_ACTION_LABEL**: Optional. notify action name define. default : `StartUp|BeforePull|AfterPull|AfterPackage`
* **NOTIFY_ACTION_LIST**: Optional. notify action list. included events will be notified. default : `BeforePull|AfterPackage`
* **NOTIFY_URL_LIST** : Optional. Notify link array , each separated by **|**
* **IFTTT_HOOK_URL_LIST** : Optional. ifttt webhook url array , each separated by **|**
* **DINGTALK_TOKEN_LIST**: Optional. DingTalk Bot TokenList, each separated by **|**
* **APP_NAME** : Optional. When setting notify, it is best to set.

---

## Volume Configuration

* **/app/target** :  builded code files will move to this folder.
* **/app/code** : source code dir. Will automatically pull the code.
* **/root/.ssh** :  If it is a private repository, please set ssh key

### ssh-keygen

`ssh-keygen -t rsa -b 4096 -C "youremail@gmail.com" -N "" -f ./id_rsa`

---

## Docker-Compose

 ```docker
version: '3'
services:
  hexo_blog:
    image: funnyzak/hexo-webhook
    privileged: true
    container_name: hexo_blog
    working_dir: /app/hook
    logging:
      driver: 'json-file'
      options:
        max-size: '1g'
    tty: true
    environment:
      - TZ=Asia/Shanghai
      - LANG=C.UTF-8
      - USE_HOOK=1
      - GIT_REPO=git@github.com:username/repo_name.git
      - GIT_BRANCH=master
      - GIT_EMAIL=youremail
      - GIT_NAME=yourname
      - AFTER_PACKAGE_COMMANDS=echo "elapsed time: $(cat /tmp/ELAPSED_TIME_LABEL)"
      - APP_NAME=vuepress_app
      - NOTIFY_ACTION_LABEL=已启动|准备拉取代码|代码已拉取|打包部署完成
      - NOTIFY_ACTION_LIST=StartUp|BeforePull|AfterPull|AfterPackage
      - NOTIFY_URL_LIST=https://request.worktile.com/asdfsfwe
      - IFTTT_HOOK_URL_LIST=https://maker.ifttt.com/trigger/event_name/with/keyhelloworld
      - DINGTALK_TOKEN_LIST=sldfj2hr923rsf2938u4sdfsf|lsdf203sjdf
    restart: on-failure
    ports:
      - 80:80
    volumes:
      - ./target:/app/target
      - ./code:/app/code
      - ./ssh:/root/.ssh

 ```

---

Please configure according to the actual deployment path and port.
