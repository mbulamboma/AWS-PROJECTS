#pull mongo db
docker pull mongo

#check images 
docker images

#run mongo
# mongoDb is the folder that will save datas of MongoDb and
# mymongoDb is the name of the image
docker run -d -p 27017:27017 -v ~/mongoDb:/data/db --name mymongoDb mongo:latest