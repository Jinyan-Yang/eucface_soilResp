# HIEv R package will download files to here:
download.path <- file.path("download/")
setToPath(download.path)

# set token for hiev
if(file.exists("c:/hiev/token.txt")){
  setToken()
}else{
  stop(c("Token need to be in c:/hiev/token.txt"))
}

#prepare the folders
o <- getwd()
if(!dir.exists("download"))dir.create("download")

library(HIEv)