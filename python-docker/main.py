#!/usr/bin/env python
##
#import os
from flask import Flask
#from flask import Markup
from flask import render_template
from flaskext.mysql import MySQL
import db_config as cfg

#print(cfg.MYSQL_DATABASE_USER)
#print(cfg.MYSQL_DATABASE_PASSWORD)
#print(cfg.MYSQL_DATABASE_DB)
#print(cfg.MYSQL_DATABASE_HOST)
#print(cfg.MYSQL_DATABASE_PORT)
#print(cfg.MYSQL_DATABASE_HOST_ALIAS)

mysql = MySQL()
app = Flask(__name__)

#app.config['MYSQL_DATABASE_HOST'] = cfg.MYSQL_DATABASE_HOST
#app.config['MYSQL_DATABASE_HOST'] = '172.17.0.3'
#app.config['MYSQL_DATABASE_PORT'] = 3306
app.config['MYSQL_DATABASE_HOST'] = cfg.MYSQL_DATABASE_HOST_ALIAS
app.config['MYSQL_DATABASE_USER'] = cfg.MYSQL_DATABASE_USER
app.config['MYSQL_DATABASE_PASSWORD'] = cfg.MYSQL_DATABASE_PASSWORD
app.config['MYSQL_DATABASE_PORT'] = int(cfg.MYSQL_DATABASE_PORT)
app.config['MYSQL_DATABASE_DB'] = cfg.MYSQL_DATABASE_DB

mysql.init_app(app)

@app.route("/message")
def message():
    cursor = mysql.connect().cursor()
    cursor.execute("SELECT message from mytable where 1")
    usrMessage = cursor.fetchone()
    print(usrMessage)
    return 'usrMessage'
    return cursor.fetchone()
    # Return the page with the result.
    #return render_template('index.html', usrMessage)

if __name__ == "__main__":
    app.run(host='0.0.0.0')
