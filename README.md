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
- Container sendiri sebenarnya berjalan diatas aplikasi Container Manager yang berjalan di sistem operasi.
- Yang membedakan dengan VM adalah, pada Container, kita bisa mem-pcakage aplikasi dan dependency-nya tanpa harus menggabungkan sistem operasi.
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
