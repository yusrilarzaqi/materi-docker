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

## Expose Instruction

- `EXPOSE` adalah instruksi untuk memberitahu bahwa container akan listen port pada nomor dan portocol tertentu.
- Instruksi `EXPOSE` tidak akan mempublish port apapun sebenarnya, instruksi `EXPOSE` hanya digunakan sebagai dokumentasi untuk memberitahu yang membuat Docker Container

### Expose Instruction Format

- Berikut adalah format untuk instruksi `EXPOSE` :
- `EXPOSE port # default nya menggunakan TCP`.
- `EXPOSE port/tcp`.
- `EXPOSE port/udp`.

### Kode : Hello World Go-Lang Web

- [Hello World Go-Lang Web](https://gist.githubusercontent.com/khannedy/9262c7784a9ef65ced9dac712822a853/raw/fb5108e45d5793a975f877acbb5038da01069410/main.go)
- Simpan dalam file main.go

### Kode : Expose Instruction

```dockerfile
FROM golang:1.18-alpine

RUN mkdir app
COPY main.go app

EXPOSE 8080

CMD go run app/main.go
```

```sh
#!/bin/bash

docker build -t yusrilarzaqi/expose .

docker image inspect yusrilarzaqi/expose
```

```
Step 1/5 : FROM golang:1.18-alpine
1.18-alpine: Pulling from library/golang
213ec9aee27d: Pull complete
5299e6f78605: Pull complete
1cab0e43db0a: Pull complete
af72e8bb74db: Pull complete
3a421caacf35: Pull complete
Digest: sha256:8e45e2ef37d2b6d98900392029db2bc88f42c0f2a9a8035fa7da90014698e86b
Status: Downloaded newer image for golang:1.18-alpine
 ---> bacc2f10e6e1
Step 2/5 : RUN mkdir app
 ---> Running in 3868726cec64
Removing intermediate container 3868726cec64
 ---> c31d758f146d
Step 3/5 : COPY main.go app
 ---> 9278d1ac3006
Step 4/5 : EXPOSE 8080
 ---> Running in 359af33b5fcb
Removing intermediate container 359af33b5fcb
 ---> 61081863f7c5
Step 5/5 : CMD go run app/main.go
 ---> Running in 050e562a99bd
Removing intermediate container 050e562a99bd
```

### Kode : Docker Container

```sh
#!/bin/bash

docker build -t yusrilarzaqi/expose .

docker container create --name expose -p 8080:8080 yusrilarzaqi/expose

docker container start expose

docker container ls
```

```
Sending build context to Docker daemon  8.704kB
Step 1/5 : FROM golang:1.18-alpine
 ---> bacc2f10e6e1
Step 2/5 : RUN mkdir app
 ---> Running in d967a63ad7f3
Removing intermediate container d967a63ad7f3
 ---> cece1fba7ad0
Step 3/5 : COPY main.go app
 ---> 91610b561b12
Step 4/5 : EXPOSE 8080
 ---> Running in d5c20506c2d7
Removing intermediate container d5c20506c2d7
 ---> 73f6911bc527
Step 5/5 : CMD go run app/main.go
 ---> Running in 8d7866419635
Removing intermediate container 8d7866419635
 ---> fcc212f5ed0f
Successfully built fcc212f5ed0f
Successfully tagged yusrilarzaqi/expose:latest
8d0e92bde7f0c58c73d1a4b1964fb3d4bfe5a1fb8fc01858f3459b831072b84e
expose
CONTAINER ID   IMAGE                 COMMAND                  CREATED        STATUS                  PORTS                                       NAMES
8d0e92bde7f0   yusrilarzaqi/expose   "/bin/sh -c 'go run …"   1 second ago   Up Less than a second   0.0.0.0:8080->8080/tcp, :::8080->8080/tcp   expose
```

## Environment Variable Instruction

- `ENV` adalah instruksi yang digunakan untuk mengubah environment variable, baik itu ketika tahapan build atau ketika jalan dalam Docker Container.
- `ENV` yang sudah di definisikan di dalam Dockerfile bisa digunakan kembali dengan menggunakan sintaks `${NAMA_ENV}`.
- Environment Variable yang dibuat menggunakan instruksi `ENV` disimpan di dalam Docker Image dan bisa dilihat menggunakan perintah docker image inpect.
- Selain itu, environment variable juga bisa diganti nilainya ketika pembuatan Docker Container dengan perintah :

```sh
docker container create --env key=value
```

### Environment Variable Instruction Format

- Berikut adalah format untuk instruksi `ENV` :
- `ENV key=value`.
- `ENV key1=value1 key2=value2`.

### Kode : Hello World Go-Lang Web dengan Port

- [Kode](https://gist.github.com/khannedy/e8574fdd9bebfb433a256e7e89f1d5ca)
- Simpan dalam file main.go

```go
package main

import (
  "fmt"
  "net/http"
  "os"
)

func main()  {
  port := os.Getenv("APP_PORT")
  fmt.Println("Server listen to port : " + port)
  http.HandleFunc("/", HelloServer )
  http.ListenAndServe(":" + port, nil)
}

func HelloServer(w http.ResponseWriter, r * http.Request) {
  fmt.Fprintf(w, "Hello, World")
}
```

### Kode : Env Instruction

```dockerfile
From golang:1.18-alpine
ENV APP_PORT=8080

RUN mkdir app
COPY main.go app

EXPOSE ${APP_PORT}
CMD go run app/main.go
```

### Kode : Docker Container

```sh
#!/bin/bash

docker build -t yusrilarzaqi/env .

```

```
Sending build context to Docker daemon  8.704kB
Step 1/6 : From golang:1.18-alpine
 ---> bacc2f10e6e1
Step 2/6 : ENV APP_PORT=8080
 ---> Running in 2d559ae3e76e
Removing intermediate container 2d559ae3e76e
 ---> 7a325da24f70
Step 3/6 : RUN mkdir app
 ---> Running in 64459176a9f5
Removing intermediate container 64459176a9f5
 ---> e3ac501ed4f7
Step 4/6 : COPY main.go app
 ---> 8dfcafd82888
Step 5/6 : EXPOSE ${APP_PORT}
 ---> Running in 274671653dc8
Removing intermediate container 274671653dc8
 ---> 50709f97d3b4
Step 6/6 : CMD go run app/main.go
 ---> Running in 8428792ed0a9
Removing intermediate container 8428792ed0a9
 ---> b707e45ab2d6
Successfully built b707e45ab2d6
Successfully tagged yusrilarzaqi/env:latest
a6052fa217585950d395a62b6aea418296a50fdb0ca16565dfa014123d5bb105
env
Server listen to port : 8080
```

## Volume Instruction

- `VOLUME` merupakan instruksi yang digunakan untuk membuat volume secara otomatis ketika kita membuat Docker Container.
- Semua file yang terdapat di volume secara otomatis akan otomatis di copy ke Docker Volume, walaupun kita tidak membuat Docker Volume ketika membuat Docker Container nya.
- Ini sangat cocok pada kasus ketika aplikasi kita misal menyimpan data di dalam file, sehingga data bisa secara otomatis aman berada di Docker Volume.

### Volume Instruction Format

- Berikut adalah format untuk instruksi `VOLUME` :
- `VOLUME /lokasi/folder`.
- `VOLUME ["lokasi/folder1", "/lokasi/folder2", "..."]`

### Golang Web dengan Write File

- [Golang Web dengan Write File](https://gist.github.com/khannedy/d788b386297caf04b39640bec43f3131)
- Simpan dalam file main.go

### Kode : Build Image

```sh
#!/bin/bash

docker build -t yusrilarzaqi/volume .

docker image ls
```

```
Sending build context to Docker daemon  4.608kB
Step 1/9 : FROM golang:1.18-alpine
 ---> bacc2f10e6e1
Step 2/9 : ENV APP_PORT=8080
 ---> Using cache
 ---> 7a325da24f70
Step 3/9 : ENV APP_DATA=/logs
 ---> Running in c24ace81c93d
Removing intermediate container c24ace81c93d
 ---> 1e450a478b23
Step 4/9 : RUN mkdir ${APP_DATA}
 ---> Running in e13123f10b0e
Removing intermediate container e13123f10b0e
 ---> 72ae491873d6
Step 5/9 : RUN mkdir app
 ---> Running in 6970dab8dd03
Removing intermediate container 6970dab8dd03
 ---> 1a48cdad4ac5
Step 6/9 : COPY main.go app
 ---> 1a6fec93c45a
Step 7/9 : EXPOSE ${APP_PORT}
 ---> Running in 778aee11b0ce
Removing intermediate container 778aee11b0ce
 ---> 6c8aee042d6c
Step 8/9 : VOLUME ${APP_DATA}
 ---> Running in 971a6ea976b0
Removing intermediate container 971a6ea976b0
 ---> 556b9b029f44
Step 9/9 : CMD go run app/main.go
 ---> Running in 2ba45441360b
Removing intermediate container 2ba45441360b
 ---> ceea93c206b3
Successfully built ceea93c206b3
Successfully tagged yusrilarzaqi/volume:latest
REPOSITORY             TAG           IMAGE ID       CREATED                  SIZE
yusrilarzaqi/volume    latest        ceea93c206b3   Less than a second ago   328MB
```

### Kode : Image Inspect

```json
{
	"Volumes": {
		"/logs": {}
	}
}
```

### Kode : Docker Container

```sh
#!/bin/bash

docker build -t yusrilarzaqi/volume .

docker container create --name volume --env APP_PORT=8080 -p 8080:8080 yusrilarzaqi/volume

docker container start volume

docker container logs volume
```

```
Sending build context to Docker daemon  9.216kB
Step 1/9 : FROM golang:1.18-alpine
 ---> bacc2f10e6e1
Step 2/9 : ENV APP_PORT=8080
 ---> Using cache
 ---> 7a325da24f70
Step 3/9 : ENV APP_DATA=/logs
 ---> Using cache
 ---> 1e450a478b23
Step 4/9 : RUN mkdir ${APP_DATA}
 ---> Using cache
 ---> 72ae491873d6
Step 5/9 : RUN mkdir app
 ---> Using cache
 ---> 1a48cdad4ac5
Step 6/9 : COPY main.go app
 ---> Using cache
 ---> 1a6fec93c45a
Step 7/9 : EXPOSE ${APP_PORT}
 ---> Using cache
 ---> 6c8aee042d6c
Step 8/9 : VOLUME ${APP_DATA}
 ---> Using cache
 ---> 556b9b029f44
Step 9/9 : CMD go run app/main.go
 ---> Using cache
 ---> ceea93c206b3
Successfully built ceea93c206b3
Successfully tagged yusrilarzaqi/volume:latest
2c77cbf41048fbb90793f9e0a70a23d57c9e5cd2514f4e73908107ead0a51965
volume
RUN app in port : 8080
DONE Write File :  /logs/yusril.txt
DONE Write File :  /logs/bimo.txt
DONE Write File :  /logs/adam.txt
DONE Write File :  /logs/dimas.txt
```

### Kode: Dokcer Container Inspect

```sh
docker container inspect volume
```

```json
{
	"Mounts": [
		{
			"Type": "volume",
			"Name": "89a9c863a40fc1e7fa0df79fe3a0cd486b65f11e568922ca883427e4ac9f5c3e",
			"Source": "/var/lib/docker/volumes/89a9c863a40fc1e7fa0df79fe3a0cd486b65f11e568922ca883427e4ac9f5c3e/_data",
			"Destination": "/logs",
			"Driver": "local",
			"Mode": "",
			"RW": true,
			"Propagation": ""
		}
	]
}
```

### Kode : Docker Volume

```sh
docker volume ls
```

```
DRIVER    VOLUME NAME
local     89a9c863a40fc1e7fa0df79fe3a0cd486b65f11e568922ca883427e4ac9f5c3e
```

## Working Direcotry Instruction

- `WORKDIR` adalah instruksi untuk menentukan direktori / folder untuk menjalankan instruksi `RUN`, `CMD`, `ENTRYPOINT`, `COPY`, `ADD`.
- Jika `WORKDIR` tidak ada, secara  otomatis direktorinya akan dibuat, dan selanjutnya setelah kita tentukan lokasi `WORKDIR` nya, direktori tersebut dijadikan tempat menjalankan instruksi selanjutnya.
- Jika lokasi `WORKDIR` adalah relative path, maka secara otomatis dia akan masuk ke direktori dari `WORKDIR` sebelumnya.
- `WORKDIR` juga bisa digunakan sebagai path untuk lokasi pertama kali ketika kita masuk ke dalam Docker Container.

### Working Direcotry Instruction Format

- Berikut adalah format untuk instruksi `WORKDIR` :
- `WORKDIR /app` artinya working direcotry nya adalah `/app`.
- `WORKDIR docker` sekarang working direcotry nya adlaah `/app/docker`.
- `WORKING /home/app` sekarang working direcotry nya adalah `/home/app`.

##

