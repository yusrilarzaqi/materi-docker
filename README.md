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
