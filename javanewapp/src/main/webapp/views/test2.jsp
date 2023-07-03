
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html>
 <body>
  <h1>test page</h1>
  
   <%
   //String name=(String)request.getAttribute("name");
   //Integer id= (Integer)request.getAttribute("id");
     
   %>
   <h1>
    Name: ${name}, id= ${id}
   </h1>
   <hr>
   
  
      <c:forEach var="item" items="${marks }">
      <h1>${item }</h1>
      </c:forEach>
   
   
   
   
   
   
   
    
    
  
 
 
 </body>
</html>