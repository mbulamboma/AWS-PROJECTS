import pymongo

myclient = pymongo.MongoClient("mongodb://ec2-13-50-241-170.eu-north-1.compute.amazonaws.com:27017/")
mydb = myclient["fuelComsuptionDB"]
mycolo = mydb["customers"]

mydic = {"name": "gilbert", "last_name": "mbula"}
x = mycolo.insert_one(mydic)