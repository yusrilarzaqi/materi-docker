# Materi Docker From Programer Zaman Now

## Docker Dasar

### Sebelum Belajar

- Mengerti tentang sistem operasi.
- Mengerti tentang menginstall applikasi.
- Mengerti cara menggunakan perintah di terminal / command line.
- Mengerti tentang Virtual Machine.

### Agenda

- Pengenalan Container.
- Pengenalan Docker.
- Menginstall Docker.
- Arsitektur Docker.
- Docker :
  - Image.
  - Registry.
  - Container.
  - Environment Variable.
  - Resource Limit.
  - Bind Mount.
  - Volume.
  - Volume Backup.
  - Volume Restore
  - Network
- Dan lain-lain.

### Pengenalan Container

#### Virtual Machine

- Dalam dunia Infrastrucutre, kita sudah terbiasa dengan namanya VM (_Virtual Machine_).
- Saat membuat sebuah VM, biasanya kita akan menginstall sistem operasi juga di VMnya.
- Masalah ketika kita menggunakan VM adalah proses yang lambat ketika pembuataan VMnya, dan butuh waktu untuk boot sistem operasi di dalam VM tersebut ketika kita menjalankan VM atau me-restart VM tersebut.

**Diagram Virtual Machine**

![Diagram Virtual Machine](./img/Diagram-Virtual-Machine.png)

#### Container

- Berbeda dengan VM,Container sendiri berfokus pada sisi Aplikasi.
- Container sendiri sebenarnya berjalan diatas aplikasi Container Manager yang berjalan di sistem operasi. Yang membedakan dengan VM adalah, pada Container, kita bisa mem-pcakage aplikasi dan dependency-nya tanpa harus menggabungkan sistem operasi.
- Container akan menggunakan sistem operasi host dimana Container Manager nya berjalan, oleh karena itu, Container akan lebih hemat resource dan lebih cepat jalan nya, karena tidak butuh sistem operasi sendiri.
- Ukuran Container biasanya hanya hitungan MB, beberapa dengan VM yang bisa sampai GB karena di dalamnya ada sistem operasinya.

**Diagram Container**

![Diagram Container](./img/Diagram-Container.png)

### Pengenalan Docker

- Docker adalah salah satu implementasi Container Manager yang saat ini paling populer.
- Docker merupakan teknologi yang masuh baru, karena baru diperkenalkan sekitar tahun 2013.
- Docker adalah aplikasi yang free dan Open Soucre, sehingga bisa kita gunakan secara bebas.
- [Docker](https://www.docker.com/)

#### Arsitektur Docker

- Docker menggunakan arsitektur Client-Server.
- Docker client berkomunikasi dengan Docker daemon (_server_).
- Saat kita menginstall Docker, biasanya didalamnya sudah terdapat Docker Client dan Docker Daemon.
- Docker Client dan Docker Daemon bisa berjalan di satu sistem yang sama.
- Docker Client dan Docker Daemon berkomunikasi menggunakan REST API.

**Diagram Docker Architecture**

![Diagram Docker Architecture](./img/Diagram-Docker-Architecture.png)

### Menginstall Docker

- Docker bisa di install hampir disebua sistem operasi.
- Untuk menginstall di Windows dan Mac, kita bisa menggunakan Docker Desktop.
- [Get Docker](https://docs.docker.com/get-docker/)
- Untuk Linux, kita bisa install dari repository sesuai distro linux masing-masing.
- [Engine install](https://docs.docker.com/engine/install/)

#### Mengecek Docker

- Untuk mengecek apakah Docker Daemon sudah berjalan, kita bisa gunakan perintah docker version.

```sh
docker version
```

### Docker Registry

- Docker Registry adalah tempat kita menyimpan Docker Image.
- Dengan menggunakan Docker Registry, kita bisa menyimpan Image yang kita buat, dan bisa digunakan di Docker Daemon dimanapun bisa terkoneksi ke Docker Registry .

**Diagram Docker Registry**
![Diagram Docker Registry](./img/Diagram-Docker-Registry.png)

#### Contoh Docker Registry

- [Docker Hub](https://hub.docker.com/)
- [Digital Ocean Container Registry](https://www.digitalocean.com/products/container-registry/)
- [Google Cloud Container Registry](https://cloud.goole.com/container-registry)
- [Amazon Elastic Container Registry](https://aws.amazon.com/id/ecr/)
- [Azure Container Registry](https://azure.microsoft.com/en-us/services/container-registry/)

### Docker Image

- Docker Image mirip seperti installer applikasi, dimana di dalam Docker Image terdapat aplikasi dan dependency.
- Sebelum kita bisa menjalankan aplikasi di Docker, kita perlu memastikan memiliki Docker Image aplikasi tersebut.

#### Melihat Docker Image

- Untuk melihat Docker Image yang terdapat di dalam Docker Daemon, kita bisa menggunakan perintah :

```sh
docker image ls
```

#### Download Docker Image

- Untuk download Docker Image dari Docker REgistry, kita bisa gunakan perintah :

```sh
docker image pull namaImage:tag
```

- Kita bisa mencari Docker Image yang ingin kita download di[docker hub](https://hub.docker.com/)

#### Kode: Download Docker Image

```sh
docker image pull redis:latest
```

#### Menghapus Docker Image

- Jika kita tidak ingin menggunakan Docker Image yang sudah kita download, kita bisa gunakan perintah :

```sh
docker image rm namaImage:tag
```

### Docker Container

- Jika Docker Image seperti installer aplikasi, maka Docker Container mirip seperti aplikasi hasil installernya.
- Satu Docker Image bisa digunakan untuk membuat beberapa Docker Container, asalkan nama Docker Containernya berbeda.
- Jika kita sudah membuat Docker Container, maka Docker Image yang digunakan tidak bisa dihapus, hal ini dikarenakan sebenarnya Docker Container tidak meng-copy isi Docker Image, tapi hanya menggunakan isinya saja.

#### Status Container

- Saat kita membuat container, secara default container tersebut tidak akan berjalan.
- Mirip seperti ketika kita menginstall aplikasi, jika tidak kita jalankan, maka aplikasi tersebut tidak akan berjalan, begitu juga container.
- Oleh karena itu, setelah membuat container, kita perlu menjalankan jika memasang ingin menjalankan containernya.

#### Melihat Container

- Untuk melihat semua container, baik yang sedang berjalan atau tidak di Docker Daemon, kita bisa gunakan perintah :

```sh
docker container ls -a
```

- Sedangkan jika kita ingin melihat container yang sedang berjalan saja, kita bisa gunakan perintah :

```sh
docker container ls
```

#### Membuat Container

- Untuk membuat container, kita bisa gunakan perintah :

```sh
docker container create --name namaContainer namaImage:tag
```

#### Kode : Membuat Container

```sh
docker container create --name contohredis redis:latest
```

#### Menjalankan Container

- Untuk menjalankan container yang sudah kita buat, kita bisa gunakan perintah :

```sh
docker container start containerId/namaContainer
```

#### Kode : Menjalankan Container

```sh
docker container start contohredis
```

#### Menghentikan Container

- Untuk menghentikan container, kita bisa gunakan perintah :

```sh
docker container stop namaImage
```

#### Kode : Menghentikan Container

```sh
docker container stop contohredis
```

#### Menghapus Container

- Untuk menghapus container yang sudah berhenti, kita bisa gunakan perintah :

```sh
docker container rm containerId/namaContainer
```

#### Kode : Menghapus Container

```sh
docker container rm contohredis
```

### Container Log

- Kadang saat terjadi masalah dengan aplikasi yang terdapat di container, sering kali kita ingin melihat detail dari log aplikasinya.
- Hal ini dilakukan untuk melihat detail kejadian apa yang terjadi di aplikasi, sehingga akan memudahkan kita ketika mendapat masalah.

#### Melihat Container Log

- Untuk melihat log aplikasi di container kita, kita bisa menggunakan perintah :

```sh
docker container logs containerId/namaContainer
```

- Atau jika ingin melihat log secara realtime, kita bisa gunakan perintah :

```sh
docker container logs -f containerId/namaContainer
```

#### Kode : Melihat Container Log

```sh
docker container logs contohredis
```

### Container Exec

- Saat kita membuat container, aplikasi yang terdapat di dalam container hanya bisa diakses dari dalam container.
- Oleh karena itu, kadang kita perlu masuk ke dalam containernya itu sendiri.
- Untuk masuk kedalam container, kita bisa menggunakan fitur `container exec`, dimana digunakan untuk mengeksekusi kode program yang terdapat di dalam container.

#### Masuk ke Container

- Untuk masuk ke dalam container, kita bisa mencoba mengeksekusi program bash script yang terdapat di dalam container dengan bantuan Container Exec :

```sh
docker container exec -i -t containerId/namaContainer /bin/bash
```

- `-i` adalah argument interaktif, menjaga input tetap aktif.
- `-t` adalah argument untuk alokasi pseudo-TTY (terminal akses).
- dan `/bin/bash` contoh kode program yang terdapat di dalam container.

#### Container Port

- Saat menjalankan container, container tersebut terisolasi di dalam Docker.
- Artinya sistem Host (misal Laptop kita), tidak bisa mengakses aplikasi yang ada di dalam container secara langsung, salah satu caranya adalah harus menggunakan Container Exec untuk masuk ke dalam container nya.
- Biasanya, sebuah aplikasi bekerja pada port tersebut, misal saat kita menjalanakan aplikasi Redis, dia berjalan pada port 6379, kita bisa melihat port apa yang digunakan ketika melihat semua daftar container.

#### Port Forwarding

- Docker memiliki kemampuan untuk melakukan port forwarding, yaitu meneruskan sebuah port yang terdapat di sistem Host nya ke dalam Docker Container.
- Cara ini cocok juka kita ingin mengekspost port yang terdapat di container ke luar melalui sistem Hostnya.

#### Melakukan Port Forwarding

- Untuk melakukan port forwarding, kita bisa menggunakan perintah berikut ketika membuat containernya :

```sh
docker container create --name namaContainer --publish postHost:postContainer image:tag
```

- Jika kita ingin melakukan port forwarding lebih dari satu, kita bisa tambahkan dua kali parameter `--publish`.
- `--publish` juga bisa disingkat menggunakan `-p`

#### Kode : Melakukan Port Forwarding

```sh
docker container create --name contohNginx --publish 8080:80 nginx:latest

docker container start contohNginx

docker container ls
```

### Container Environment Variable

- Saat membuat aplikasi, menggunakan Environment Variable adalah salah satu teknik agar konfigurasi aplikasi bisa diubah secara dinamis.
- Dengan menggunakan environment variable, kita bisa mengubah-ubah konfigurasi aplikasi, tanpa harus mengubah kode aplikasinya lagi.
- Docker Container memiliki parameter yang bisa kita gunakan untuk mengirim environment variable ke aplikasi yang terdapat di dalam container.

#### Menambah Environment Variable

- Untuk menambah environment variable, kita bisa menggunakan perintah `--env` atau `-e` misal :

```sh
docker container create --name namaContainer --env KEY="value" --env KEY2="value" image:tag
```

#### Kode : Menambah Environment Variable

```sh
docker container create --name contohmongo --publish 27017:27017 --env MONGO_INITDB_ROOT_USERNAME=yusri --env MONGO_INITDB_ROOT_PASSWORD=yusril123 mongo:latest

docker container ls -a
```

### Container Stats

- Saat menjalankan beberapa container, di sistem Host, penggunaan resource seperti CPU dan Memory hanya terlihat digunakan oleh Docker saja.
- Kadang kita ingin melihat detail dari penggunaan resource untuk tiap containernya.
- Untungnya docker memiliki kemampuan untuk melihat penggunaan resource dari tiap container yang sedang berjalan.
- Kita bisa gunakan perintah :

```sh
docker container stas
```

### Container Resource Limit

- Saat membuat container, secara default dia akan menggunakan semua CPU dan Memory yang tersedia di sistem Host (Linux)
- Jika terjadi kesalahan, misal container terlalu banyak memakan CPU dan Memory, maka bisa diberikan ke Docker (Mac dan Windows), dan akan menggunakan semua CPU dan Memory, maka bisa berdampak terhadap performa container lain, atau bahkan ke sistem host.
- Oleh karena itu, ada baiknya ketika kita membuat container, kita memberikan resource limit terhadap containernya.

#### Memory

- Saat membuat container, kita bisa menentukan jumlah memory yang bisa digunakan oleh container ini, dengan menggunakan perintah `--memory` diikuti dengan angka memory yang diperbolehkan untuk digunakan.
- Kita bisa menambahkan ukuran dalam bentuk b (bytes), k (kilo bytes), m (mega bytes), atau g (giga bytes), misal 100m artinya 100 mega bytes.

#### CPU

- Selain mengatur Memory, kita juga bisa menentukan beberapa jumlah CPU yang bisa digunakan oleh container dengan parameter `--cpus`.
- Jika misal kita set dengan 1.5, artinya container bisa menggunakan satu dan setengah CPU core.

#### Kode : Menambah Resource Limit

```sh
docker container create --name smallnginx --publish 8081:80 --memory 100m --cpus 0.5 nignx:latest

docker container start smallnginx

docker container ls
```

### Bind Mounts

- Bind Mounts merupakan kemampuan melakukan mounting (sharing) file atau folder yang terdapat di sistem host ke container yang terdapat di docker.
- Fitur ini sangat berguna ketika misal kita ingin mengirim konfigurasi dari luar container, atau misal menyimpan data yang dibuat di aplikasi di dalam container ke dalam folder di sistem host.
- Jika file atau folder tidak ada di sistem host, secara otomatis akan dibuatkan oleh Docker.
- Untuk melakukan mounting, kita bisa menggunakan parameter `--mount` ketika membuat container.
- Isi dari parameter `--mount` memiliki aturan tersendiri.

#### Parameter Mount

| Parameter   | Keterangan                                                                        |
| ----------- | --------------------------------------------------------------------------------- |
| type        | Tipe mount, bind atau volume                                                      |
| soruce      | Lokasi file atau folder di sistem host                                            |
| destination | Lokasi file atau folder di container                                              |
| readonly    | Jika ada, maka file atau folder hanya bisa dibaca di container tidak bisa ditulis |

#### Melakukan Mounting

- Untuk melakukan mounting, kita bisa menggunakan perintah berikut :

```sh
docker container create --name namaContainer --mount "type:bind,source=folder,destination=folder,readonly" image:tag
```

#### Kode : Melakukan Mounting

```sh
docker container create --name mongodata --mount "type=bind,source=/home/yusril/Documents/materi-docker/mongo-data,destination=/data/db" --publish 27017:27017 --env MONGO_INITDB_ROOT_USERNAME=yusril --env MONGO_INITDB_ROOT_PASSWORD=yusril123 mongo:latest

docker container start mongodata

docker container ls
```

### Docker Volume

- Fitur Bind Mounts sudah ada sejak Docker versi awal, di versi terbaru direkomendasikan menggunakan **Docker Volume**.
- Docker Volume mirip dengan Bind Mounts, bedanya adalah terdapat management Volume, dimana kita bisa membuat Volume, melihat daftar Volume, dan menghapus Volume.
- Volume sendiri bisa dianggap storage yang digunakan untuk menyimpan data, bedanya dengan Bind Mounts, pada bind, data disimpan pada sistem host, sedangkan pada volume, data di manage oleh Docker.

#### Melihat Docker Volume

- Saat kita membuat container, dimanakah data di dalam container itu disimpan, secara default semua data container disimpan di dalam volume.
- jika kita coba melihat docker volume, kita akan lihat bahwa ada banyak volume yang sudah terbuat, walaupun kita belum pernah membuatnya sama sekali.
- Kita bisa gunakan perintah berikut untuk melihat daftar volume :

```sh
docker volume ls
```

#### Kode : Melihat Volume

```sh
docker volume ls
```

| DRIVER | VOLUME NAME                                                      |
| ------ | ---------------------------------------------------------------- |
| local  | 6b7abb869d59505c94f3338da3f29c8cfdc1dd56522ce52f6d7edadebb4be973 |
| local  | 13d1871d1ce2053031454e4c21518c65aa60620211775d66a0d552d5200fd14b |
| local  | 64b632ac5cc319057feceba9310dcf8ab6b6856cee0fbccba50082ad7f3ae31c |
| local  | 160a2ac355db94a0705d2fcda08a4115e97651b56ef64188ba99df72248f4c28 |
| local  | 533e5c4d64347d02f165462e4ffe2c4fb53e18754f1f012474227a7c8ba1f45d |
| local  | 3213cf0c47f60a9fd51e97d7b138fbccbe8f3bb41456aa171f709d9ef0a6bf08 |
| local  | b4ce338975ce34e054a96173b82f8cdf5bfffc3be22b20acc7756aaaaea7bdf4 |
| local  | b59bfe6bc08a9fe8d20045447a7e2b1598debec8764055cdff0c585393bd35fa |

#### Membuat Volume

- Untuk membuat volume, kita bisa gunakan perintah :

```sh
docker volume create namaVolume
```

#### Kode : Membuat Volume

```sh
docker volume create mongovolume
```

| DRIVER | VOLUME NAME                                                      |
| ------ | ---------------------------------------------------------------- |
| local  | 6b7abb869d59505c94f3338da3f29c8cfdc1dd56522ce52f6d7edadebb4be973 |
| local  | 13d1871d1ce2053031454e4c21518c65aa60620211775d66a0d552d5200fd14b |
| local  | 64b632ac5cc319057feceba9310dcf8ab6b6856cee0fbccba50082ad7f3ae31c |
| local  | 160a2ac355db94a0705d2fcda08a4115e97651b56ef64188ba99df72248f4c28 |
| local  | 533e5c4d64347d02f165462e4ffe2c4fb53e18754f1f012474227a7c8ba1f45d |
| local  | 3213cf0c47f60a9fd51e97d7b138fbccbe8f3bb41456aa171f709d9ef0a6bf08 |
| local  | b4ce338975ce34e054a96173b82f8cdf5bfffc3be22b20acc7756aaaaea7bdf4 |
| local  | b59bfe6bc08a9fe8d20045447a7e2b1598debec8764055cdff0c585393bd35fa |
| local  | mongovolume                                                      |

#### Menghapus Volume

- Volume yang tidak digunakan oleh container bisa kita hapus, tapi jika volume digunakan oleh container, maka tidak bisa kita hapus sampai container nya dihapus.
- Untuk menghapus volume, bisa kita gunakan perintah

```sh
docker volume rm namaVolume
```

#### Kode menghapus Volume

```sh
docker volume rm mongovolume
```

| DRIVER | VOLUME NAME                                                      |
| ------ | ---------------------------------------------------------------- |
| local  | 6b7abb869d59505c94f3338da3f29c8cfdc1dd56522ce52f6d7edadebb4be973 |
| local  | 13d1871d1ce2053031454e4c21518c65aa60620211775d66a0d552d5200fd14b |
| local  | 64b632ac5cc319057feceba9310dcf8ab6b6856cee0fbccba50082ad7f3ae31c |
| local  | 160a2ac355db94a0705d2fcda08a4115e97651b56ef64188ba99df72248f4c28 |
| local  | 533e5c4d64347d02f165462e4ffe2c4fb53e18754f1f012474227a7c8ba1f45d |
| local  | 3213cf0c47f60a9fd51e97d7b138fbccbe8f3bb41456aa171f709d9ef0a6bf08 |
| local  | b4ce338975ce34e054a96173b82f8cdf5bfffc3be22b20acc7756aaaaea7bdf4 |
| local  | b59bfe6bc08a9fe8d20045447a7e2b1598debec8764055cdff0c585393bd35fa |

#### Container Volume

- Volume yang sudah kita buat, bisa kita gunakan di container.
- Keuntungan menggunakan volume adalah, jika container kita hapus, data akan tetap aman di volume.
- Cara menggunakan di container sama dengan menggunakan bind mount, kita bisa menggunakan parameter `--mount`, namun dengna menggunakan type volume dan source nama volume.

```sh
$ docker volume create mongodata

$ docker container create --name mongovolume --mount "type=volume,source=mongodata,destination=/data/db" -publish 27017:27017 --env MONGO_INITDB_ROOT_USERNAME=yusril --env MONGO_INITDB_ROOT_PASSWORD=yusril123  mongo:latest

$ docker container start mongovolume
```

### Backup Volume

- Sayangnya, sampai saat ini, tidak ada cara otomatis melakukan backup volume yang sudah kita buat.
- Namun kita bisa memanfaatkan container untuk melakukan backp data yang ada di dalam volume ke dalam archive seperti `zip` atau `tar.gz`.

#### Tahapan Melakukan Backup

- Matikan container yang menggunakan volume yang ingin kita backup.
- Buat container degnan dua mount, volume yang ingin kita backup, dan bind mount folder dari sistem host.
- Lakukan backup menggunakan container dengan cara meng-archive isi volume, dan simpan di bind mount folder.
- Isi file backup sekarang ada di folder host.
- Delete container yang kita gunakan untuk melakukan backup.

#### Kode : Membuat Backup Container

```sh
$ docker container create --name nginxbackup --mount "type=bind,source=/home/yusril/Documents/materi-docker/backup,destination=/backup" --mount "type=volume,source=mongodata,destination=/data" nginx:latest

$ docker container exec -it nginxbackup /bin/bash

$ tar cvf /backup/backup.tar.gz /data

$ docker stop nginxbackup

$ docker container rm nginxbackup

$ docker start mongovolume
```

#### Menjalankan Container Secara Langsung

- Melakukan backup secara manual agak sedikit ribet karena kita harus start container terlebih dahulu, setelah backup, hapus containernya lagi.
- Kita bisa menggunakan perintah `run` untuk menjalankan perintah di container dan gunakan parameter `--rm` untuk melakukan otomatis remove container setelah perintahnya selesai berjalan.

#### Kode : Backup Dengan Container Run

```sh
$ docekr stop mongovolume

$ docker container run --rm --name ubuntu --mount "type=bind,source=/home/yusril/Documents/materi-docker/backup/,destination=/backup" --mount "type=volume,source=mongodata,destination=/data" ubuntu:latest tar cvf /backup/backup1.tar.gz /data
```

### Restore Volume

- Setelah melakukan backup volume ke dalam file archive, kita bisa menyimpan file archive backup tersebut ke tempat yang lebih aman, misal ke cloud storage.
- Sekarang kita kana coba melakukan restore data backup ke volume baru, untuk memastikan data backup yang kita lakukan tidak corrupt.

#### Tahapan Melakukan Restore

- Buat volume baru untuk lokasi restore data backup.
- Buat container baru dengan dua mount, volume baru untuk restore backup, dan bind mount folder dari sistem host yang berisi file backup.
- Lakukan restore menggunakan container dengan cara meng-extract isi backup file ke dalam volume.
- Isi file backup sekarang sudah di resotre ke volume.
- Delete container yang kita gunakan untuk melakukan resotre.
- Volume baru yang berisi data backup siap digunakan oleh container baru.

#### Kode : Restore Backup

```sh
$ docker volume create mongorestore

$ docker container run --rm --name ubuntubackup --mount "type=bind,source=/home/yusril/Documents/materi-docker/backup,destination=/backup" --mount "type=volume,source=mongorestore,destination=/data" ubuntu:latest bash -c "cd /data/db && tar xvf /backup/backup.tar.gz --strip 1"
```

### Docker Network

- Saat kita membuat container di docker, secara default container akan saling terisolasi satu sama lain, jadi jika kita mencoba memanggil antar container, bisa dipastikan bahwa kita tidak akan bisa melakukannya.
- Docker memiliki fitur Network yang bisa digunakan untuk membuat jaringan di dalam Docker.
- Dengan menggunakan Network, kita bisa mengkoneksikan container dengan container lain dalam satu Network yang sama.
- Jika beberapa container terdapat pada satu Network yang sama, maka secara otomatis container tersebut bisa saling berkomunikasi.

#### Network Driver

- Saat kita membuat Network di Docker, kita perlu menentukan driver yang ingin kita gunakan, ada banyak driver yang bisa kita gunakan, tapi kadang ada syarat sebuah driver network bisa kita gunakan.
- _bridge_, yaitu driver yang digunakan untuk membuat network secara vitual yang memungkinkan container yang terkoneksi di bridge network yang sama saling berkomunikasi.
- _host_, yaitu driver yang digunakan untuk membuat network yang sama dengan sistem host. Host hanya jalan di Docker Linux, tidak bisa digunakan di Mac atau Windows.
- _none_, yaitu driver yang membuat network yang tidak bisa berkomunikasi.

#### Melihat Network

- Untuk melihat network di Docker, kita bisa gunakan perintah :

```sh
docker network ls
```

#### Kode Melihat Network

```sh
docker network ls
```

| NETWORK ID   | NAME   | DRIVER | SCOPE |
| ------------ | ------ | ------ | ----- |
| db7a63dc66ab | bridge | bridge | local |
| 477a49b3d086 | host   | host   | local |
| 53dbcbfb730b | none   | null   | local |

#### Membuat Network

- Untuk membuat network baru, kita bisa menggunakan perintah :

```sh
docker network create --driver namaDriver namaNetwork
```

> default value untuk driver adalah bridge

#### Kode : Membuat Network

```sh
$ docker network create --driver bridge contohnetwork

0d2cee0ee546dd400b0e6262899ad4b25f0ef4dfdd11f1b3e8bd55bf95a98b5f

$ docker network ls

NETWORK ID     NAME            DRIVER    SCOPE
db7a63dc66ab   bridge          bridge    local
0d2cee0ee546   contohnetwork   bridge    local
477a49b3d086   host            host      local
53dbcbfb730b   none            null      local
```

#### Menghapus Network

- Untuk menghapus Network, kita bisa gunakan perintah :

```sh
docker network rm namaNetwork
```

- Network tidak bisa dihapus jika sudah digunakan oleh container. Kita harus menghapus container nya terlebih dahulu dari Network.

#### Kode : Menghapus Network

```sh
$ docker network rm contohnetwork

contohnetwork

$ docker network ls

NETWORK ID     NAME            DRIVER    SCOPE
db7a63dc66ab   bridge          bridge    local
477a49b3d086   host            host      local
53dbcbfb730b   none            null      local
```
