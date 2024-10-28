## <h1><p align="center">Deployment of a Flask app(Simple login page) with AWS services</p></h1>
<p align="center">
  <img src="https://github.com/AWS-Re-Start-RDC-KINSHASA-1/LoadBalance-Config-MenaVeko/assets/90093320/9fe4f07b-0cca-4f29-9c2a-2dbe655ef187" />

</p>
<h2>Purpose of this deployment</h2>

We want to use this simple app to show how to deploy an app in the cloud using the AWS LoadBalance and the Autoscale services. And the below diagram show the result of the configuration.

<img src="https://github.com/AWS-Re-Start-RDC-KINSHASA-1/LoadBalance-Config-MenaVeko/assets/90093320/fdc216bc-c3a0-4955-887e-498578b36289" />

<h2>Start the configuration</h2>
Feel free to just copie the code that I provided in the LoginPage folder you will find the Flask app and its templates, the Config-userdata folder contain the userdata script that you will put in the server configuration and his template.
<h3>1-The Flask App</h3>
Create a simple flask app that will help you to understand the configuration then you will update to your desire appliaction.
Don't forget to put this line :

```
if __name__ == '__main__':
    app.run(host='0.0.0.0', debug=True, port=5000)
```

If you notice in the below screenshot my Flask login page it's running in the port 3000, its the default configuration for the test. We will use the port 5000 for this lab. This is the result that you will have if you take my code.
<img src="https://github.com/AWS-Re-Start-RDC-KINSHASA-1/LoadBalance-Config-MenaVeko/assets/90093320/44a80bc9-b7ae-45bc-b2e7-4b9376291a48" />

<h3>2-Star the configuration on AWS Console</h3>
Connect into your AWS console. 
<ol>
  <li>Create the server :</li> 
  Write in the search bar EC2. This will open the console where we launch the EC2 instance, and click "Launch instances".
  <ul>
    <li>
      Give a name to your server :
      <img src="https://github.com/AWS-Re-Start-RDC-KINSHASA-1/LoadBalance-Config-MenaVeko/assets/90093320/4e6e3c36-9502-4bdd-ac7b-ab53e8179564"/>
    </li>
    <li>Select the image of your OS :</li>
    In the "Application and OS Imges (Amazon Machine Image)" section in the Quick Start select Amazon Linux, and in the Amazon Machine Image select the Amazon Linux 2 (Free tier eligible). 
    <li>Instance Type :</li>
    Choose the t2.micro.
    <li>Key pair (login) :</li>
    Create a new key pair, give it a name (ex : KeyTest1) and select the .pem extention then download the file. After that select it i the field of the Key pair name that's is required.
    <li>Network Settings :</li>
    Let it in the "Create security group", it will provide you a security group in the defaults VPC. But don't forget to allow SSH traffic, HTTP and HTTPS from the internet, after that click in the Lauch instance in your right.
  </ul>
  <li>Configure the server :</li>
  And to achieve this task, we have to download mobaxterm, we will use it to connect and interact with the server.
  This is a link to download it : https://mobaxterm.mobatek.net/download.html
  <ul>
    <li>Connect with Mobaxterm :</li>
    Select your server in my case is it ServerTest1, after that in the details section we copy the Public IPv4 adress.
    <img src="https://github.com/AWS-Re-Start-RDC-KINSHASA-1/LoadBalance-Config-MenaVeko/assets/90093320/832cbf80-0c65-496c-b12c-febdd6113887"/>
    Then click in Session, another window will appear their you have to click and paste the IP of your server, after that write the specify username (ec2-user), then check the Use private key and a window will open to your file managment go and select the key pair, then click OK. And know you are connected to the server.
    <img src="https://github.com/AWS-Re-Start-RDC-KINSHASA-1/LoadBalance-Config-MenaVeko/assets/90093320/57069317-0617-4b2d-80ff-f160fd7d5f2c"/>
  <li>Install git, httpd, python3-pip, flask :</li>
  Always start with updating the server 
    
```
sudo yum update -y
```
  If its said  that there is no package available then go to step,
```
sudo yum install git -y
```
  Then install httpd
```
sudo yum -y install httpd
```
  Enable the service and start it with 
```
sudo systemctl enable httpd
sudo systemctl start httpd
```
  Now you can check if httpd work with
```
sudo systemctl  status httpd
```
  You should see something like this:
  <img src="https://github.com/AWS-Re-Start-RDC-KINSHASA-1/LoadBalance-Config-MenaVeko/assets/90093320/1b14d888-81a8-4764-8f61-431fed31bf9a"/>

  Install flask 
```
pip3 install flask
```
  <li>Clone your project using GitHub, run it in background :</li>
  Go to /var/www directorie
  
```
cd /var/www
```
  Then clone the project in there
```
sudo git clone https://github.com/AWS-Re-Start-RDC-KINSHASA-1/LoadBalance-Config-MenaVeko.git
cd LoadBalance-Config-MenaVeko
```
  After that execute the app.py in the background
```
nohup flask run --host=0.0.0.0 --port=5000 > /dev/null 2>&1 &
```
Now you are eable to connect to the LoginPage using the IP of the server + the port 5000 (IP of the server:5000), but it will didn't work, we have first to add a inboud rule for the port 5000 in the security group that we create later on this tutoriels.
  <li>Add an inbound rule in the security group :</li>
  Select the the server and go in the Security section, their click in the link below the Security groups.
  <img src="https://github.com/AWS-Re-Start-RDC-KINSHASA-1/LoadBalance-Config-MenaVeko/assets/90093320/60d33f0f-1648-427a-bea9-cc43fe8d92dc"/>
  In the Inbound rules click on the "Edit inbound rules" button, it will take you to this window
  <img src="https://github.com/AWS-Re-Start-RDC-KINSHASA-1/LoadBalance-Config-MenaVeko/assets/90093320/b68afa80-4c6a-47e7-afe6-6bb3e2658899"/>
  First add rule, then write on the Port range the port that we use in our case is 5000, add 0.0.0.0 and save rules.
  And know we can see our LoginPage appear in the browser using the Ip of the server.
  <img src="https://github.com/AWS-Re-Start-RDC-KINSHASA-1/LoadBalance-Config-MenaVeko/assets/90093320/18ba4edd-dec4-4019-a000-8aeb11733af4"/>
  </ul>
  <li>Configure the LoadBalance and the Auto Scaling Group :</li>
  <ul>
    <li>Application Load Balancer</li>
    In the left section in the Load Balacing part, select the Load Balancers, then in the right Create load balancer.
  Choose the Application Load Balancer, select create.
    In the field Basic configuration, we have the filed "Load balancer name" give a name to your new Load Balancer. Let the default VPC and select the two first subnet for this configuration. 
    In the security groups part select the the security group that you use for your instance. In the Listeners and routing part make sure that you let the HTTP protocol with his defaults port 80, click on the create target group to create one.
    <img src="https://github.com/AWS-Re-Start-RDC-KINSHASA-1/LoadBalance-Config-MenaVeko/assets/90093320/26b2c2c5-ec3b-45c6-932c-5b005bd92bff"/>
    Choose for the target type : Instances.
    Give a name for the target group.
    And in the Protocol field let the HTTP, and add 5000 for the port, then go to next
    First select the target group and Includes as pending below, after that click on "Create target group".
    <img src="https://github.com/AWS-Re-Start-RDC-KINSHASA-1/LoadBalance-Config-MenaVeko/assets/90093320/bf858f1b-520e-4f9f-9c35-8f98dbf80f5a"/>
    After creating the target group, retrun and continue to the "Review" section and click in "Create load balancer" to finish the configuration.
    <li>Auto Scaling Group</li>
    In the left section in the Auto Scaling part at the end, select the Auto Scaling Groups, then in the right Create Auto Scaling Group.
    Give a name to your Auto Scaling group name.
    and create a launch template if you didn't have a template.
    <img src="https://github.com/AWS-Re-Start-RDC-KINSHASA-1/LoadBalance-Config-MenaVeko/assets/90093320/f5e14f27-e735-4b5b-a799-1ec20b5900d8"/>
    First give a name for the template.
    Configure the template in the same way that we did for configuring the information of the system.
    Go to the Advanced details section, in the end of it we have the user data, put the code that I provided in the config-userdata, this will install all the configuration that we did in the "Configure server" section.
    <img src="https://github.com/AWS-Re-Start-RDC-KINSHASA-1/LoadBalance-Config-MenaVeko/assets/90093320/e4748707-8dfd-4e19-9cec-0430b82a97e0"/>


    

  </ul>
  
  
</ol>





