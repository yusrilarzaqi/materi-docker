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
- Docker
  - Image.
  - Registry.
  - Container.
  - Environment Variable
  - Volume.
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

- Untuk download Docker Image dari Docker REgistry, kita bisa gunakan pertinah :

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
- Mirip seperti ketika kita menginstall aplikasi, jika tidak kita jalankan, maka aplikasi tersebut tidaka akan berjalan, begitu juga container.
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

