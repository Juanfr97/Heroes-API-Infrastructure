resource "kubernetes_persistent_volume_claim" "mongodb-pvc" {
  metadata {
    namespace = "heroes-api"
    name      = "mongodb-pvc"
  }
  spec {
    access_modes       = ["ReadWriteOnce"]
    storage_class_name = "do-block-storage"
    resources {
      requests = {
        storage = "3Gi"
      }
    }
  }
}
resource "time_sleep" "wait_for_pv" {
  depends_on      = [kubernetes_persistent_volume_claim.mongodb-pvc]
  create_duration = "10s"
}
resource "kubernetes_config_map" "mongo_init" {
  metadata {
    name = "mongo-init"
    namespace = "heroes-api"
  }
  data = {
    "init.sh" = <<EOF
     #!/bin/bash
    # Need to wait for the readiness health check to pass so that the
    HOST=mongo-0.mongo:27017
    until /usr/bin/mongosh --host=mongo-0.mongo:27017 --eval 'printjson(db.serverStatus())'; do
      echo "connecting to remote mongo..."
      sleep 2
    done

    # Insert data
    echo "Feeding db..."
    /usr/bin/mongosh --host=mongo-0.mongo:27017 --eval 'use dbheroes;'
     # Wait until MongoDB is ready
    until /usr/bin/mongosh --host=mongo-0.mongo:27017 --eval 'db.createCollection("heroes"); '; do
      echo "Waiting for MongoDB..."
      sleep 2
    done
    echo "Datos insertados exitosamente."

    # Wait until MongoDB is ready
    until /usr/bin/mongosh --host=mongo-0.mongo:27017 --eval 'db.heroes.insertMany([{
      "superhero": "Batman",
      "publisher": "DC Comics",
      "alter_ego": "Bruce Wayne",
      "first_appearance": "Detective Comics #27",
      "characters": "Bruce Wayne"
    },{
      "superhero": "Superman",
      "publisher": "DC Comics",
      "alter_ego": "Kal-El",
      "first_appearance": "Action Comics #1",
      "characters": "Kal-El",
      "image": "https://sm.ign.com/ign_latam/screenshot/default/super_s31e.jpg"
    },{
      "superhero": "Flash",
      "publisher": "DC Comics",
      "alter_ego": "Jay Garrick",
      "first_appearance": "Flash Comics #1",
      "characters": "Jay Garrick, Barry Allen, Wally West, Bart Allen",
      "image": "https://img.europapress.es/fotoweb/fotonoticia_20220802114647_420.jpg"
    },{
      "superhero": "Green Lantern",
      "publisher": "DC Comics",
      "alter_ego": "Alan Scott",
      "first_appearance": "All-American Comics #16",
      "characters": "Alan Scott, Hal Jordan, Guy Gardner, John Stewart, Kyle Raynor, Jade, Sinestro, Simon Baz",
      "image": "https://i.blogs.es/c12af0/2224860-2011_green_lantern_movie_1680x1050/1366_2000.jpeg"
    },{
      "superhero": "Green Arrow",
      "publisher": "DC Comics",
      "alter_ego": "Oliver Queen",
      "first_appearance": "More Fun Comics #73",
      "characters": "Oliver Queen",
      "image": "https://dam.smashmexico.com.mx/wp-content/uploads/2018/10/22155903/Top-5-green-arrow-diferencias-comic-serie-tv-cover.jpg"
    },{
      "superhero": "Wonder Woman",
      "publisher": "DC Comics",
      "alter_ego": "Princess Diana",
      "first_appearance": "All Star Comics #8",
      "characters": "Princess Diana",
      "image": "https://i.blogs.es/fc7807/wonder-woman0/1366_2000.jpg"
    },{
      "superhero": "Martian Manhunter",
      "publisher": "DC Comics",
      "alter_ego": "Jonn Jonzz",
      "first_appearance": "Detective Comics #225",
      "characters": "Martian Manhunter",
      "image": "https://www.geekmi.news/__export/1665263878362/sites/debate/img/2022/10/08/silver-surfer.jpg_375108060.jpg"
    },{
      "superhero": "Robin/Nightwing",
      "publisher": "DC Comics",
      "alter_ego": "Dick Grayson",
      "first_appearance": "Detective Comics #38",
      "characters": "Dick Grayson",
      "image": "https://sm.ign.com/t/ign_es/feature/n/nightwing-/nightwing-explained-who-is-the-former-batman-sidekick_se3y.h720.jpg"
    },{
      "superhero": "Blue Beetle",
      "publisher": "DC Comics",
      "alter_ego": "Dan Garret",
      "first_appearance": "Mystery Men Comics #1",
      "characters": "Dan Garret, Ted Kord, Jaime Reyes",
      "image": "https://dam.smashmexico.com.mx/wp-content/uploads/2021/10/quien-es-blue-beetle-heroe-latino-pelicula-dc.jpg"
    },{
      "superhero": "Black Canary",
      "publisher": "DC Comics",
      "alter_ego": "Dinah Drake",
      "first_appearance": "Flash Comics #86",
      "characters": "Dinah Drake, Dinah Lance",
      "image": "https://dossierinteractivo.com/wp-content/uploads/2022/01/Black-Canary-portada.jpeg"
    },{
      "superhero": "Spider Man",
      "publisher": "Marvel Comics",
      "alter_ego": "Peter Parker",
      "first_appearance": "Amazing Fantasy #15",
      "characters": "Peter Parker",
      "image": "https://upload.wikimedia.org/wikipedia/commons/9/90/Spiderman.JPG"
    },{
      "superhero": "Captain America",
      "publisher": "Marvel Comics",
      "alter_ego": "Steve Rogers",
      "first_appearance": "Captain America Comics #1",
      "characters": "Steve Rogers"
    },{
      "superhero": "Iron Man",
      "publisher": "Marvel Comics",
      "alter_ego": "Tony Stark",
      "first_appearance": "Tales of Suspense #39",
      "characters": "Tony Stark",
      "image": "https://as01.epimg.net/meristation/imagenes/2021/05/07/betech/1620421981_410581_1620422287_noticia_normal_recorte1.jpg"
    },{
      "superhero": "Thor",
      "publisher": "Marvel Comics",
      "alter_ego": "Thor Odinson",
      "first_appearance": "Journey into Myster #83",
      "characters": "Thor Odinson",
      "image": "https://cdn.forbes.com.mx/2020/01/thor-640x360.jpeg"
    },{
      "superhero": "Hulk",
      "publisher": "Marvel Comics",
      "alter_ego": "Bruce Banner",
      "first_appearance": "The Incredible Hulk #1",
      "characters": "Bruce Banner",
      "image": "https://imagenes.elpais.com/resizer/L5TH7vm_VCPQPUnWd7W32zjsKJg=/1960x1470/arc-anglerfish-eu-central-1-prod-prisa.s3.amazonaws.com/public/5VQ345JWCOOBMP5SWYZEFU4BBM.jpg"
    },{
      "superhero": "Wolverine",
      "publisher": "Marvel Comics",
      "alter_ego": "James Howlett",
      "first_appearance": "The Incredible Hulk #180",
      "characters": "James Howlett",
      "image": "https://www.geekmi.news/__export/1642090244332/sites/debate/img/2022/01/13/disexo_x27x.jpg_242310155.jpg"
    },{
      "superhero": "Daredevil",
      "publisher": "Marvel Comics",
      "alter_ego": "Matthew Michael Murdock",
      "first_appearance": "Daredevil #1",
      "characters": "Matthew Michael Murdock",
      "image": "https://www.lacasadeel.net/wp-content/uploads/2022/01/daredevil-5-comics-conocer-mejor-hombre-sin-miedo_crop1607623664340.jpg_1902800913.webp"
    },{
      "superhero": "Hawkeye",
      "publisher": "Marvel Comics",
      "alter_ego": "Clinton Francis Barton",
      "first_appearance": "Tales of Suspense #57",
      "characters": "Clinton Francis Barton",
      "image": "https://phantom-marca.unidadeditorial.es/849369c8142aa9c12784f0f9e36b6652/resize/1320/f/jpg/assets/multimedia/imagenes/2021/12/22/16401920712795.jpg"
    },{
      "superhero": "Cyclops",
      "publisher": "Marvel Comics",
      "alter_ego": "Scott Summers",
      "first_appearance": "X-Men #1",
      "characters": "Scott Summers",
      "image": "https://cloudfront-us-east-1.images.arcpublishing.com/metroworldnews/LXHJVJPXHRCYFFUVCWO4PN7MHQ.jpg"
    },{
      "superhero": "Silver Surfer",
      "publisher": "Marvel Comics",
      "alter_ego": "Norrin Radd",
      "first_appearance": "The Fantastic Four #48",
      "characters": "Norrin Radd",
      "image": "https://www.geekmi.news/__export/1665263878362/sites/debate/img/2022/10/08/silver-surfer.jpg_375108060.jpg"
    }]
    );' dbheroes; do
      echo "Waiting for MongoDB to start..."
      sleep 2
    done
    echo "Datos insertados exitosamente."

    # Container will exit after this script is run, so we need to sleep forever
    while true; do
      sleep 3600
    done
    EOF
  }
}
resource "kubernetes_stateful_set" "mongodb_sfs" {
  depends_on = [time_sleep.wait_for_pv, kubernetes_config_map.mongo_init]
  metadata {
    namespace = "heroes-api"
    name      = "mongo"
  }
  spec {
    service_name = "mongo"
    replicas     = 1
    selector {
      match_labels = {
        app = "mongo"
      }
    }
    template {
      metadata {
        labels = {
          app = "mongo"
        }
      }
      spec {
        container {
          name    = "mongo"
          image   = "mongo:6.0.6"
          port {
            container_port = 27017
          }
          volume_mount {
            name       = "mongodb-pvc"
            mount_path = "/data/db"
          }
        }
        container {
          name = "init-mongo"
          image = "mongo:6.0.6"
          termination_message_path = "/dev/termination-log"
          termination_message_policy = "File"
          command = [ "bash","/config/init.sh" ]
          volume_mount {
            name       = "config"
            mount_path = "/config"
          }
        }
        volume {
          name = "mongodb-pvc"
          persistent_volume_claim {
            claim_name = "mongodb-pvc"
          }
        }
        volume {
          name = "config"
          config_map {
            name = "mongo-init"
            default_mode = "0420"
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "mongo_svc" {
  metadata {
    name      = "mongo"
    namespace = "heroes-api"
    labels = {
      app = "mongo"
    }
  }
  spec {
    cluster_ip = "None"
    port {
      port = 27017
      name = "peer"
    }
    selector = {
      app = "mongo"
    }
  }
}