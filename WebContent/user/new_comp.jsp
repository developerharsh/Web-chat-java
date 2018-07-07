<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.util.Iterator,java.util.List,org.hibernate.*,org.hibernate.cfg.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title> New complaint</title>
        <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.3.1/semantic.min.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.3.1/semantic.min.js"></script>
        <link rel="stylesheet" type="text/css" href="newcomp.css">
    </head>


    <body>
        <div class="ui fixed inverted menu">
            <div class="ui container">
                <div class="header item"><i class="code icon nav"></i>Complaint Portal</div>
                <a href="user_landing.jsp" class="item"><i class="home icon nav"></i>Home</a>
                <a  style="position:absolute;left:90%" href="logout.jsp" class="item">Logout<i style="margin-left: 2px;size:2 em;"class="sign out alternate icon nav"></i></a>
            </div>
        </div> 


<div class="ui main text container segment" style="margin-top: 100px">
    <div class="ui huge header center aligned">New Complaint</div>

    <form class="ui form" method="POST" action="add_comp.jsp" enctype="multipart/form-data">
       

  <div class="field">
    
    <input type="text" name="subject" placeholder="Subject goes here ...">
  </div>
  
  <div class="field">
    
    <input type="text" name="desc" placeholder="Description...">
    
  </div>

<%

Object vali=session.getAttribute("userid");
if(vali==null){
	response.sendRedirect("user_signin.jsp");
}
else{
Configuration cfg=new Configuration();
cfg.configure("Hibernate.cfg.xml");
System.out.println("Loaded Configuration .........");

SessionFactory sf=cfg.buildSessionFactory();
System.out.println("Loaded SessionFactory ..........");

Session s=sf.openSession();
System.out.println("Loaded Session ..........");

Query q= s.createSQLQuery("select * from reqtype");
List l = q.list();
Iterator it = l.iterator();%>

  <div class="field">
     
  <select class="ui dropdown" name="type">
  <option value="">Type</option>
  <% while(it.hasNext())
{
	String st = (String)it.next();%>
    <option value="<%=st%>"><%=st%></option>
    <% 
	System.out.println(st.toString());
}%>
</select>
  </div>


  <div class="field">
     <select class="ui dropdown" name="priority">
  		<option value="">Priority</option>
  		<option value="High">High</option>
  		<option value="Medium">Medium</option>
  		<option value="Low">Low</option>
	</select>
  </div>

  <div class="field">
    <select class="ui dropdown" name="module">
  <option value="">Module</option>
  <% q= s.createSQLQuery("select * from modules");
     l = q.list();
     it = l.iterator();%>
  
   <% while(it.hasNext())
{
	String st = (String)it.next();%>
    <option value="<%=st%>"><%=st%></option>
    <% 
	System.out.println(st.toString());
}%>
</select>
  </div>

  <div class="field">
    <label>Attachments:</label>
    <input type="file" name="filename">
    
  </div>
  
  <br>
  <button class="ui button" type="submit">Submit</button>
    </form>
</div>
<%
s.close();
sf.close();
}%>
<script>
    $('.ui.dropdown')
  .dropdown()
;
</script>


    </body>
    </html>