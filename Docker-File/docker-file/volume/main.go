package main

import (
  "fmt"
  "io/ioutil"
  "net/http"
  "os"
)

func main() {
  port := os.Getenv("APP_PORT")
  fmt.Println("RUN app in port : " + port)
  http.HandleFunc("/", HelloServer)
  http.ListenAndServe(":" + port, nil)
}

func HelloServer(w http.ResponseWriter, r *http.Request)  {
  fmt.Fprintf(w, "Hello, %s", r.URL.Path[1:])

  dataString := "Hello " + r.URL.Path[1:]
  dataBytes := []byte(dataString)

  destintaion := os.Getenv("APP_DATA")
  file := destintaion + "/" + r.URL.Path[1:] + ".txt"
  err := ioutil.WriteFile(file, dataBytes, 0666)

  if err != nil {
    panic(err)
  }
  
  fmt.Println("DONE Write File : ", file)
}
