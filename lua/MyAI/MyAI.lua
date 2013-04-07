--连接数据库
require "sqlite3"
db = sqlite3.open("./lua/MyAI/test.db")
db:exec("CREATE TABLE userLoin (username text,general text);")




