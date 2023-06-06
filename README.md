# E-commerce-project-springBoot
This a web application Java Based  Beginner level project To developing the e-commerce website to Buy/sell the Food Item. We use the Spring Boot to build the back-end part

## Old Version
- https://github.com/jaygajera17/E-commerce-project-springBoot/tree/main
- issue: everytime connection open close for access database 

## New Upgrade ( what's new)
- Hibernate configuration added( database and tables automatically create when run the project)
- Service classes provide reusable services throughout project
- dao classes interact with database 
- bug fixed ( product image, security , etc..)
- support in both eclipse & intellij ide
- overall redesign entire code that help reusability. 
- disclaimer: currently working on this branch so there may be some bug related to endpoint, and working on cart logic.

## How to Run ?
- open xampp control panel start mysql server
- go to Resource->application.properties file change db properties username,password according to yours
- Run the project ( by build pom.xml file or right click and run main class JtSpringprojectApplication.java)
- open http://localhost:8080/ there we go.

# Workflow
- ![image](https://github.com/jaygajera17/E-commerce-project-springBoot/assets/81226571/69951cb7-65e2-4225-8681-2542859aaec6)
### Controller
- control the endpoint and also send data to view( we use ModelAndView method)
- ``` @GetMapping("login")
	public String adminlogin() {
		
		return "adminlogin";
	}```
- whenever /login url is hit , src->main->webapp-> adminlogin.jsp file execute
### Models
- represent data as entity and relationship among them.

### View
- receive data from controller and show with frontend.


## Endpoints
- http://localhost:8080/
- http://localhost:8080/register
- http://localhost:8080/admin/products
- http://localhost:8080/admin/customers
- http://localhost:8080/admin/categories
- http://localhost:8080/admin/Dashboard



## Preview
![image](https://github.com/jaygajera17/E-commerce-project-springBoot/assets/81226571/02a04d3c-1fc9-418c-b231-639f6525d07e)
![image](https://github.com/jaygajera17/E-commerce-project-springBoot/assets/81226571/24c4451b-43a6-4c23-a78a-786eab4303b0)
![image](https://github.com/jaygajera17/E-commerce-project-springBoot/assets/81226571/93c1baeb-326c-450f-867e-a883900a6644)

## Link
- 𝗬𝗼𝘂𝘁𝘂𝗯𝗲 𝗽𝗿𝗼𝗷𝗲𝗰𝘁 𝘃𝗶𝗱𝗲𝗼 𝗪𝗼𝗿𝗸𝗶𝗻𝗴 𝗗𝗲𝗺𝗼 + 𝘀𝘁𝗲𝗽 𝗯𝘆 𝘀𝘁𝗲𝗽 𝗲𝘅𝗲𝗰𝘂𝘁𝗶𝗼𝗻 𝗹𝗶𝗻𝗸  ( old version )::---  [  click here  ](https://youtu.be/c6WWdINWSlI) [![youtube][youtube-shield]][youtube-url]
- Special thanks to [DAKSHAY111](https://github.com/DAKSHAY111) for their valuable contributions to the project!  

[youtube-shield]:https://img.shields.io/youtube/views/c6WWdINWSlI?style=social
[youtube-url]:  https://youtu.be/c6WWdINWSlI


