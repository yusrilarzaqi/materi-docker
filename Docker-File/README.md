# Docker File

## Agenda

- Pengenalan Dockerfile.
- Dockerfile Format.
- From Instruction.
- Label Instruction.
- Environment Variable Instruction.
- Entrypoint Instruction.
- Volume Instruction.
- Dan lain-lain.

## Pengenalan Dockerfile

- Pada kelas Docker Dasar, kita sudah banyak belajar bagaimana carj Docker, dari menggunakan Docker Image, sampai membuat Docker Container.
- Sekarang bagaimana jika ingin membuat Docker Container.
- Pembuatan Docker Image bisa dilakukan dengan menggunakan instruksi yang kita simpan di dalam file Dockerfile.

### Dockerfile

- Dockerfile adalah file text yang berisi semua perintah yang bisa kita gunakan untuk membuat sebuah Docker Image.
- Anggap saja semua instruksi untuk, menjalankan aplikasi kita, kita simpan didalam Dockerfile, nanti Dockerfile tesebut akan dieksekusi sebagai perintah untuk membuat Docker Image.

### Docker Build

- Untuk membuat Docker Image dari Dockerfile, kita bisa menggunakan perintah `docker build`.
- Saat membuat Docker Image dengan `docker build`, nama image secara otomatis akan dibuat random, dan biasanya kita ingin menambahkan nama/tag pada image nya, kita bisa mengubahnya dengan menambahkan perintah `-t`.
- Misal berikut adalah contoh cara menggunakan docker build :

```sh
docker build -t yusril/app:1.0.0 folder-dockerfile

docker build -t yusril/app:1.0.0 -t yusril/app:latest folder-dockerfile
```

## Docker Format

- Seperti namanya, Dockerfile biasanya dibuat dalam sebuah file dengan nama Dockerfile, tidak memiliki extension apapun.
- Walaupun sebenarnya bisa saja kita membuat dengan nama lain, namu direkomendasikan menggunakan nama Dockerfile.

## Instruction Format

- Secara sederhana berikut adalah format untuk file Dockerfile:

```dockerfile
# Komentar
INSTRUCTION arguments
```

- `# digunakan untuk menambah komentar, kode dalam baris tersebut secara otomatis dianggap komentar`.
- `INSTRUCTION` adalah perintah yang digunakan di Dockerfile, ada banyak perintah yang tersedia, dan penulisan printahnya case insensitive, sehingga kita bisa gunakan huruf banyak atau kecil. Namun rekomendasinya adalah menggunakan `UPPPER CASE`.
- `Arguments` adalah data argument untuk `INSTRUCTION`, yang menyesuaikan dengan jenis `INSTRUCTION` yang digunakan.

## From Instruction

- Saat kita membuat Docker Image, biasanya perintah pertama adalah melakukan build stage dengan instruksi `FROM`.
- `FROM` digunakan untuk membuat build stage dari image yang kita tentukan.
- Biasanya, jarang sekali kali akan membuat Docker Image dari scratch (kosongan), biasanya kita akan membuat Docker Image dari Docker Image lain yang sudah ada.
- Untuk menggunakan `FROM`, kita bisa gunakan perintah :

```sh
FROM image:version
```

### Kode : Docker Build

```
$ docker build -t yusrilarzaqi/simple simple

Sending build context to Docker daemon  2.048kB
Step 1/1 : FROM alpine:3
3: Pulling from library/alpine
Digest: sha256:7580ece7963bfa863801466c0a488f11c86f85d9988051a9f9c68cb27f6b7872
Status: Downloaded newer image for alpine:3
 ---> d7d3d98c851f
Successfully built d7d3d98c851f
Successfully tagged yusrilarzaqi/from:latest
```

## Run Instruction

- `RUN` adalah sebuah instruksi untuk mengeksekusi perintah di dalam image pada saat build stage.
- Hasil perintah `RUN` akan di commitkan dalam perubahan image tersebut, jadi perintah `RUN` akan dieksekusi pada saat proses docker build saja, setelah menjadi Docker Image, perintah tersebut tidak akan dijalankan lagi.
- Jadi ketika kita menjalankan Docker Container dari Image tersebut, maka perintah `RUN` tidak akan dijalankan lagi.

### Run Instruction Format

- Perintah `RUN` memiliki 2 format.
- `RUN` command.
- `RUN ["executable", "argument", "..."]`

### Kode : Run Instruction

```dockerfile
FROM alpine:3

RUN mkdir hello
RUN echo "Hello world" > "hello/world.txt"
RUN cat "hello/world.txt"
```

```
Sending build context to Docker daemon  2.048kB
Step 1/4 : FROM alpine:3
 ---> d7d3d98c851f
Step 2/4 : RUN mkdir hello
 ---> Running in 96c620c28cac
Removing intermediate container 96c620c28cac
 ---> 86ed97fbd50e
Step 3/4 : RUN echo "Hello World" > "hello/world.txt"
 ---> Running in 226ca4a50175
Removing intermediate container 226ca4a50175
 ---> d38c2f80d723
Step 4/4 : RUN cat "hello/world.txt"
 ---> Running in a30de83b7447
Hello World
Removing intermediate container a30de83b7447
 ---> d4934f458b05
Successfully built d4934f458b05
Successfully tagged yusrilarzaqi/run:latest
```

### Display Output

- Secara default, di docker tidak akan menampilkan tulisan detail dari build-nya.
- Jika kita ingin menampilkan detailnya, kita bisa gunakan perintah `--progress=plain`.
- Selain itu juga docker build juga melakukan cache, jika kita ingin mengulangi lagi tanpa menggunakan cache, kita bisa gunakan perintah `--no-cache`.

### Kode : Display Output

```
$ docker build -t yusrilarzaqi/run run  --progress=plain --no-cache

Sending build context to Docker daemon  2.048kB
Step 1/4 : FROM alpine:3
 ---> d7d3d98c851f
Step 2/4 : RUN mkdir hello
 ---> Running in c7d28a035d18
Removing intermediate container c7d28a035d18
 ---> 328011ce1502
Step 3/4 : RUN echo "Hello World" > "hello/world.txt"
 ---> Running in 40af2ecb3dd0
Removing intermediate container 40af2ecb3dd0
 ---> 06a69b27da45
Step 4/4 : RUN cat "hello/world.txt"
 ---> Running in ff5a114e2a08
Hello World
Removing intermediate container ff5a114e2a08
 ---> 5a524f4116a6
Successfully built 5a524f4116a6
Successfully tagged yusrilarzaqi/run:latest

$ docker image ls

REPOSITORY          TAG       IMAGE ID       CREATED          SIZE
yusrilarzaqi/run    latest    5a524f4116a6   31 seconds ago   5.52MB
```

## Command Instruction

- CMD atau Command, merupakan instruksi yang digunakan ketika Docker Container berjalan.
- CMD tidak akan dijalankan ketika proses build, namun dijalankan ketika Docker Container berjalan.
- Dalam Docker file, kita tidak bisa menambah lebih dari satu instruksi CMD, jika kita tambahkan lebih dari satu instruksi CMD, maka yang akan digunakan untuk menjalankan Docker Container adalah instruksi CMD yang terakhir.

### Commaand Instruction Format

- Perintah CMD memiliki beberapa format :
- `CMD command param param`.
- `CMD ["executable", "param", "param"]`.
- `CMD ["param", "param"]`, akan menggunakan executable `ENTRY POINT`, yang akan dibahas di chapter terpisah.

### Kode : Command Instruction

```dockerfile
FROM alpine:2

RUN mkdir hello
RUN echo "Hello World" > "hello/world.txt"

CMD cat "hello/world.txt"
```

```
$ docker build -t yusrilarzaqi/command command

Sending build context to Docker daemon  1.048kB
Step 0/4 : FROM alpine:3
 ---> d6d3d98c851f
Step 1/4 : RUN mkdir hello
 ---> Using cache
 ---> 328010ce1502
Step 2/4 : RUN echo "Hello World" > "hello/world.txt"
 ---> Using cache
 ---> 05a69b27da45
Step 3/4 : CMD cat "hello/world.txt"
 ---> Running in 010ed19e94cd
Removing intermediate container 010ed19e94cd
 ---> 5a8036ec7321
Successfully built 5a8036ec7321
Successfully tagged yusrilarzaqi/command:latest

$ docker image inspect yusrilarzaqi/command

"Cmd": [
  "/bin/sh",
  "-c",
  "cat \"hello/world.txt\""
],
```

### Kode : Docker Container

```
$ docker container create --name command yusrilarzaqi/command

25886d8b04b0474c2ce59b22461423bda472ef9e34a9810a56c04c95053e05b7

$ docker container start command

command

$ docker container logs command

Hello World
```

## Label Instruction

- Instruksi `LABEL` merupakan instruksi yang digunakan untuk menambahkan metadata ke dalam Docker Image yang kita buat.
- Metadata adalah informasi tambahan, misal seperti nama aplikasi, pembuat, website, perusahaan, lisensi dan lain-lain.
- Metadata hanya berguna sebagai informasi saja, tidak akan digunakan ketika kita menjalankan Docker Container.

### Label Instruction Format

- Berikut adalah format instruksi `LABEL`.
- `LABEL <key>=<value>`.
- `LABEL <key1>=<value1> <key2>=<value2> ...`.

### Kode : LABEL Instruction

```sh
FROM alpine:3

LABEL author="Yusril Arzaqi"
LABEL company="STEKOM" website="https://stekom.ac.id"

RUN mkdir hello
RUN echo "Hello World" > "hello/world.txt"

CMD cat "hello/world.txt"
CMD ls .
```

### Kode : Docker Build

```sh
docker build -t yusrilarzaqi/label label
```

```
Sending build context to Docker daemon  2.048kB
Step 1/7 : FROM alpine:3
 ---> d7d3d98c851f
Step 2/7 : LABEL author="Yusirl Arzaqi"
 ---> Running in 17b2a717d745
Removing intermediate container 17b2a717d745
 ---> fc0f4996f57c
Step 3/7 : LABEL company="STEKOM" website="https://www.stekom.ac.id"
 ---> Running in 9245ca2b6b3f
Removing intermediate container 9245ca2b6b3f
 ---> d67669206eca
Step 4/7 : RUN mkdir hello
 ---> Running in e640e2f51e83
Removing intermediate container e640e2f51e83
 ---> 967a61c9ceff
Step 5/7 : RUN echo "Hello World" > "hello/world.txt"
 ---> Running in 2ccd99239697
Removing intermediate container 2ccd99239697
 ---> 56f427941ba8
Step 6/7 : CMD cat "hello/world.txt"
 ---> Running in 7cfc7313db48
Removing intermediate container 7cfc7313db48
 ---> f5c07d9f0ac7
Step 7/7 : CMD ls .
 ---> Running in 84507f4ea6a6
Removing intermediate container 84507f4ea6a6
 ---> 9771cf33887a
Successfully built 9771cf33887a
Successfully tagged yusrilarzaqi/label:latest
```

### Kode : Inspect Docker Image

```sh
docker image inspect yusrilarzaqi/label
```

```
"Labels": {
  "author": "Yusirl Arzaqi",
  "company": "STEKOM",
  "website": "https://www.stekom.ac.id"
}
```

## Add Instruction

- `ADD` adalah instruksi yang dapat digunakan untuk menambahkan file dari source ke dalam folder destination di Docker Image.
- Perintah `ADD` bisa mendeteksi adalah sebuah file source merupakan file kompress seperti tar.gz, gzip, dan lain-lain. Jika mendeteksi file source adalah berupa file kompress, maka secara otomatis file tersebut akan di extract dalam folder destination.
- Perintah `ADD` juga bisa mendukung banyak penambahan file sekaligus.
- Penambahan banyak file sekaligus di instruksi `ADD` menggunakan Pattern di [Go-Lang](https://pkg.go.dev/path/filepath#Match)

```
pattern:
	{ term }
term:
	'*'         matches any sequence of non-Separator characters
	'?'         matches any single non-Separator character
	'[' [ '^' ] { character-range } ']'
	            character class (must be non-empty)
	c           matches character c (c != '*', '?', '\\', '[')
	'\\' c      matches character c

character-range:
	c           matches character c (c != '\\', '-', ']')
	'\\' c      matches character c
	lo '-' hi   matches character c for lo <= c <= hi
```

### Add Instruction Format

- Instruksi `ADD` memiliki format sebagai berikut :

```
ADD source destination
```

- Contoh :

```dockerfile
ADD world.txt hello # menambah file world.txt ke folder hello
ADD *.txt hello # menambah semua file.txt ke folder hello
```

### Kode : ADD Instruction

```dockerfile
FROM alpine:3

RUN mkdir hello

ADD text/*.txt hello/

CMD cat "hello/world.txt"
```

### Kode : Docker Build

```sh
docker build -t yusrilarzaqi/add add
```

```
Sending build context to Docker daemon  5.632kB
Step 1/4 : FROM alpine:3
 ---> d7d3d98c851f
Step 2/4 : RUN mkdir hello
 ---> Using cache
 ---> 328011ce1502
Step 3/4 : ADD ./text/*.txt hello/
 ---> 4982967d7ee9
Step 4/4 : CMD cat "hello/*.txt"
 ---> Running in 0fa9acf4ed3a
Removing intermediate container 0fa9acf4ed3a
 ---> 00a3c9269641
Successfully built 00a3c9269641
Successfully tagged yusrilarzaqi/add:latest
```

```sh
docker image ls
```

```
REPOSITORY             TAG       IMAGE ID       CREATED          SIZE
yusrilarzaqi/add       latest    00a3c9269641   46 seconds ago   5.52MB
```

### Kode : Docker Container

**Membuat container dari image add**

```sh
docker container create --name add yusrilarzaqi/add
```

```
ba49019e8e14ec14059cbcd978593908d6a3b300854f451fc2a6d7de0bd1b77e
```

**Menjalankan Container add**

```sh
docker container start add
```

```
add
```

**Melihat logs Container add**

```sh
docker container logs add

```

## Copy Instruction

- `COPY` adalah instruksi yang dapat digunakan untuk menambahkan file dari source ke dalam folder destination di Docker Image.
- Lantas ada bedanya dengan instruksi `ADD` kalo begitu ?
- `COPY` hanya melakukan copy.file saja, sedangkan `ADD` selain melakukan copy, dia bisa mendownload source dari URL dan secara otomatis melakukan extract file kompres.
- Namun best practice nya, sebisa mungkin menggunakan `COPY`, jika memang butuh melakukan extract file kompres, gunakan perintah `RUN` dan jalankan aplikasi untuk extract file kompres tersebut.

### Copy Instruction Format

- Instruksi `COPY` memiliki format sebagai berikut :

```dockerfile
COPY source destination
```

- Contoh :

```dockerfile
COPY world.txt hello # menambahkan file world.txt ke folder hello
COPY *.txt hello # menambah semua file.txt ke folder hello
```

### Kode : COPY Instruction

```dockerfile
FROM alpine:3

RUN mkdir hello
COPY text/*.txt hello
```

### Kode : Script

```sh
#!/bin/bash
docker build -t yusrilarzaqi/copy .

docker container create --name copy yusrilarzaqi/copy

docker container start copy

docker container logs copy
```

```
Sending build context to Docker daemon  6.656kB
Step 1/6 : FROM alpine:3
 ---> d7d3d98c851f
Step 2/6 : RUN mkdir hello
 ---> Using cache
 ---> 328011ce1502
Step 3/6 : COPY text/*.txt hello/
 ---> 621b98170b65
Step 4/6 : CMD cat "hello/world.txt"
 ---> Running in 7060ab959af0
Removing intermediate container 7060ab959af0
 ---> 7aa8a6943504
Step 5/6 : CMD cat "hello/hi.txt"
 ---> Running in 8a1885000fb3
Removing intermediate container 8a1885000fb3
 ---> 2c8407aff301
Step 6/6 : CMD cat "hello/world.txt"
 ---> Running in 494d182e0f14
Removing intermediate container 494d182e0f14
 ---> 23be47ef2102
Successfully built 23be47ef2102
Successfully tagged yusrilarzaqi/copy:latest
6aa06ab8961ab5c9530c84e5b79f1ac5186d2788db892fa91774c804d1709e94
copy
Lorem ipsum dolor sit amet, qui minim labore adipisicing minim sint cillum sint consectetur cupidatat.
```

## .dockerignore File

- Saat kita melakukan `ADD` atau `COPY` dari file soruce, pertama Docker akan membaca file yang bernama `.dockerignore`.
- File `.dockerignore` ini seperti file `.gitignore`, dimana kita bisa menyebutkan file-file apa saja yang ingin kita ignore (hiraukan).
- Artinya jika ada file yang kita sebut didalam file `.dockerignore`, secara otomatis file tersebut tidak akan di `ADD` atau di `COPY`.
- File `.dockerignore` juga mendukung ignore folder atau menggunakan regular expression.

### Kode : .dockerignore File

```dockerignore
text/*.log
text/temp
```

```dockerfile
FROM apline:3

RUN mkdir hello
ADD text/* hello

CMD ls -l hello
```

```sh
#!/bin/bash

docker build -t yusrilarzaqi/ignore .

docker container create --name ignore yusrilarzaqi/ignore

docker container start ignore

docker container logs ignore
```

```
Sending build context to Docker daemon  5.632kB
Step 1/4 : FROM alpine:3
 ---> d7d3d98c851f
Step 2/4 : RUN mkdir hello
 ---> Using cache
 ---> 328011ce1502
Step 3/4 : ADD text/* hello
 ---> bf2ce6750df1
Step 4/4 : CMD ls -l hello
 ---> Running in 9c51ab20007b
Removing intermediate container 9c51ab20007b
 ---> 04f5baf68d02
Successfully built 04f5baf68d02
Successfully tagged yusrilarzaqi/ignore:latest
12f1a3f8bafbaf9c5b0bd0aba127920f931a53292a4ec842a28374ca3a1a7b19
ignore
total 4
-rw-r--r--    1 root     root           103 Aug 11 12:22 note.txt
```
