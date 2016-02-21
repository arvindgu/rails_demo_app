This repository contains an example of rails web application, named as globalbank to demostrate how to use ibm_db gems to connect to IBM DB2 databases.

To run this globalbank application, follow below steps:

1. Install latest version of Ruby and Rails.

2. Install ibm_db gems with below command.
   gem install rails

3. If you are connecting to IBM DB2 zOS or iSeries database, copy DB2Connect license in <ibm_db gem installation directory>/lib/clidriver/license.

4. Verify Ruby driver installation with interactive Ruby shell, run below commands.
	irb
	require 'ibm_db'
	conn=IBM_DB.connect("hostname=<hostname>;port=<port>;UID=<user_id>;PWD=<password>;authentication=server;database=<database_name>","","")
	Change <hostname>, <port>, <user_id>, <password> and <database_name> accordingly in above command.
      
	If you get output like below, that means connection was succesful
	=> #<IBM_DB::Connection:0x2dddf40>
	
	Now close the connection by running below command
	IBM_DB.close(conn)

5. Get this example application code from Git by running below command.
   git clone https://github.com/arvindgu/rails_demo_app
   
6. Edit the database.yml which is present in config directory.
	Specify Database host, port, username, password, Schema, host, port, database  details and save it.

	default: &default
	  adapter: ibm_db
	  username: <username>
	  password: <password>  	  
	  host: <hostname>
	  port: <port>
	  authentication: SERVER
	  
	development:
	  <<: *default
	  database: <database>
 
	test:
		<<: *default
		database: <database>
  
7. Run bundle install to download missing gems.
	$bundle install	

8. Now run below command to create tables in database.
   rake db:migrate	

9. Run below comamnd to start web server. By default it runs on localhost and 3000 as default port number.
   rails server   

   To access remotely, you need to start with binding the machine IP address. You can also change default port number via below command.
   rails s --binding=<host_name_or_ip_Address> --port=<port_number>
   
10. To access globalbank application open browser and invoke 
	http://<host_name_or_ip_Address>:<port_number>   
	
	
	
	
	
	
	
	
	
	
	