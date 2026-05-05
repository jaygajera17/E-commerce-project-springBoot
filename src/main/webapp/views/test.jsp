<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="java.text.*"%>
<%@page import ="java.io.FileOutputStream" %>    
<%@page import=" java.io.ObjectOutputStream" %>    

<!DOCTYPE html>

<html>
 <body>
  <h1>test page</h1>
  <% String s=(String)request.getAttribute("author"); 
     Integer id=(Integer)request.getAttribute("id");
     List<String> friends=(List<String>)request.getAttribute("f");
  %>
  <h1> author name is <%=s %> </h1>
  <h1> Id is <%=id %> </h1>
   
   <% 
   for(String st:friends)
   {
    %>
    <h1> <%=st %></h1>
    <%
    } 
    %>
    
    
  
 
 
 </body>
</html>