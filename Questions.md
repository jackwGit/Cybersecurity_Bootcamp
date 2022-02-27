# USyd Cybersecurity Bootcamp - Project 1 ELK Stack Project



## Summary

This document answers the interviewing questions in three cybersecurity domains -
* Network Security
* Cloud Security
* Logging and Monitoring



## Structure of Answers

Restate the Problem -- Provide a Concrete Example Scenario -- Explain the Solution Requirements -- Identify Advantages and Disadvantages -- Explain the Solution Details

* Answer the concept to the problem
* An example scenario
* What to do to tackle above example scenario in high level (ie. no detailed operation steps)
* What can be done better
* Detailed steps if required



### Network Security

1. Faulty Firewall
   
   > **Answer**
   > <br></br>
   > It is important to set up the required firewall rules and test the rules are implemented properly as this will reduce attack surface and provide the minimal exposure to the public.
   > <br></br>
   > As an example in Project 1, the Jump-Box VM is used for the engineers to configure the other VMs (Web-1, Web-2 and ELK Web-4 VMs). The web VMs only serve the purpose of providing web access (HTTP). The web VMs should reject all SSH connection.
   > <br></br>
   > If one of VMs unexpectedly accepted SSH connection, the firewall was not set up correctly. In the project 1, the infrastructure is set up on Azure and the firewall is configured using the Network Security Group (NSG) service.   
   > When the configuration is updated, I will check from the engineer computer make sure the connection is working. Then try from a different computer that has a different public IP and make sure that the connection is rejected.
   > <br></br>
   > In more details, I would go to Azure NSG to check the rules. Note that the rule priority is higher with lower number. I would start from the lowest number (highest priority) to check.  
   > For each rule, I will check the source IP, destination IP, destination port and the protocol.  
   > There should be a firewall rule to only allow my PC (public IP) to connect to the Jump-Box VM (Jump-Box private IP) via SSH on TCP/22. And there is a default rule to block all public connections on any port. 
      > <br></br>
      > My PC's public IP might change (depends on the ISP). Whenever the public IP changes, I need to change the NSG rules. Moreover, if my PC is connection to a network doesn't provide public IP (such as 4G), then my PC will not be able to connection to the Jump-Box VM.
   

   
2. Unsecured Web Server

   > **Answer**
   > <br></br>
   > It is important to comply with the guideline that encrypted connection HTTPS is used, as un-encrypted HTTP traffic can be intercepted and hence the data.
   > <br></br>
   > In Project 1, both Web-1 and Web-2 are running DVWA on HTTP on TCP/80, as well as Kibana. The reason is that the set up is for laboratory environment only. In addition, NSG is only allowing my PC to access.  
   > In a real world production deployment, all these VMs that have web applications and need to expose publicly should have HTTPS with proper SSL certificate. The encrypted traffic will protect users' data (such as password) when the traffic is intercepted.
   > <br></br>
   > Connecting to a web application on HTTP port 80 is a big risk if the client PC is connecting to a public network (such as a public WIFI) where attacker can intercept the traffics (such as Man-In-The-Middle attack). And the intercepted traffic are shown in plain text.  
   > The server needs to change from HTTP to HTTPS. If a proper certificate cannot be obtained, at least use a self-signed certificate.
   > However, although the traffic is encrypted with HTTPS connection, for a self-signed certificate, the client cannot verify the certificate is legitimate.
   > <br></br>
   > Openssl can be used on the web VMs to generate a pair of private key and public key. Make sure that both web-1 and web-2 are using the same keys, whereas ELK web-4 should have a separate pair of keys.  
   > Then bind the SSL certificate to the Apache server.
   > <br></br>
   > My solution will comply with the clients requirement that using HTTPS 443 encrypted traffic. However, for production environment, need to use proper SSL server. 



### Cloud Security

1. Cloud Access Control

   * Least  privilege
   * Only allow the required personel to access the specific resources if needed
   * NSG to allow inbound to jump box only, NSG to allow jump box to Web VMs only, use SSH key instead of password to avoid brute-force
   * Hard to maintain and scale when there is a new user. Alternative solution is VPN gateway

  > **Sample answer:**
  > <br></br>
  > It's important that organizations control access to a cloud network, especially since it has resources that only the engineering team should be able to access. Following the principle of least privilege, you want to make sure engineers can access it easily, but no one else can.
  > <br></br>
  > In Project 1 of my cybersecurity bootcamp, we solved an almost identical problem. In that project, we deployed a virtual network containing several VMs to Azure, which only we and our instructional team were supposed to be able to access. Just as an organization would limit cloud network access to only engineers, we had to implement remote access controls limiting access to only a handful of authorized individuals.
  > <br></br>
  > After deploying the network, I first had to configure a network security group around the whole subnet. This blocked traffic from all IP addresses, except for mine, my partners', and my instructors'. This NSG allowed inbound access to only one machine on the internal network, the jump box.  
  > Then, I configured additional NSGs on the VMs within the subnet. This allowed connections only between the jump box and other local IP addresses.  
  > Finally, I forced the use of SSH keys to eliminate vulnerability to password-based brute-force.
  > <br></br>
  > This solution worked well for my project because it ensured only the selected users had access. However, it is difficult to maintain and scale because it requires updating the NSG every time a new user requires access to the network. In addition, securely using SSH keys can be tricky in the long run. An alternative solution addressing these shortcomings would be implementing a VPN gateway to the private network. This would allow us to manage and monitor users more safely and scalably.
  > <br></br>
  > To configure access controls around the entire subnet, I created an NSG with the following ruleset: […] These rules allow access to the jump box from only the specified IP addresses specified.  
  > Then, to configure access controls within the subnet, I created NSGs with the following ruleset: […] These rules allow the VMs within the network to communicate only with each other and with the jump box.  
  > To force the use of SSH keys, I modified the following configurations in the VMs on the network: [...] This ensures that password brute-force attacks will always fail.



2. Corporate VPN



3. Containers



4. Cloud Infrastructure as Code



# Logging and Monitoring

1. Setting Alerts in a New Monitoring System



2. Challenges of Collecting Large Amounts of Log Data



3. Escalating Security Events

