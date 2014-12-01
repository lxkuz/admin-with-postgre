**Kemerovo invest portal**

  **Requirements:**

    * Ruby version 2.1.3
    * PostgreSQL 9.2

  **System dependencies**
  
    JDK (7 and above) or OpenJDK (6 and above)
    Elasticsearch (1.3.4)*
    libcurl3 libcurl3-gnutls libcurl4-openssl-dev

  ** Configuration**

    Ruby on Rails 4.1.6
  
  **Installing Elasticsearch**

    Debian/Ubuntu:

      ! Required pre-installed JDK or OpenJDK

      Java Development Kit (Oracle)
        sudo add-apt-repository ppa:webupd8team/java
        sudo apt-get update
        sudo apt-get install oracle-java8-installer
      or
      OpenJDK
        sudo apt-get update
        sudo apt-get install openjdk-6-jre

      Elasticsearch

        wget -qO - http://packages.elasticsearch.org/GPG-KEY-elasticsearch | sudo apt-key add -

        ! Add in /etc/apt/sources.list
          deb http://packages.elasticsearch.org/elasticsearch/1.3/debian stable main

        sudo apt-get update
        sudo apt-get install elasticsearch
        sudo service elasticsearch start
        
        Installing Elasticsearch Morphology plugin

        ! Execute from /usr/share/elasticsearch
        bin/plugin -install analysis-morphology -url http://dl.bintray.com/content/imotov/elasticsearch-plugins/org/elasticsearch/elasticsearch-analysis-morphology/1.2.0/elasticsearch-analysis-morphology-1.2.0.zip
        sudo service elasticsearch restart

        ! Copy config from config/elasticsearch.yml.example to /etc/elasticsearch/elasticsearch.yml.example
        ! Update indexes from project directory
        bundle exec rake environment elasticsearch:import:all

 
  **Starting development**

    Debian/Ubuntu:

      git clone git@bitbucket.org:mystand/admin-with-postgre.git
      cd admin-with-postgre
      sudo apt-get install libcurl3 libcurl3-gnutls libcurl4-openssl-dev
      bundle
      rails s
      get http://localhost:3000

  **Deployment instructions**

     Add public ssh key to ~/.ssh/authorized_keys in kemerovo-invest@new.mystand.ru

     - deploy:
         bundle exec cap production deploy

     - start server:
         bundle exec cap production unicorn:start

     - restart server:
         bundle exec cap production deploy:restart
       or
         bundle exec cap production unicorn:restart

     - stop server:
         bundle exec cap production unicorn:stop
       or
         bundle exec cap production unicorn:force_stop

       get http://kemerovo-invest-portal2.mystand.ru

  ** Translations

    Для полей, которые необходимо локализовать указывать тип hstore

```
#!ruby

      create_table :posts do |t|
        t.hstore :title
        t.hstore :content
      end

```


    В модели для нужных аттрибутов указать

```
#!ruby

      class Post < ActiveRecord::Base
        multilang :title, :content
      end

```


    Более подробная информация здесь https://github.com/bithavoc/multilang-hstore