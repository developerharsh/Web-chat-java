<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.util.Iterator,java.util.List,org.hibernate.*,org.hibernate.cfg.*,java.math.BigDecimal,userLogin.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
    	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Synopsis</title>
        <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.3.1/semantic.min.css">
        <link rel="stylesheet" type="text/css" href="hist.css">
    </head>

    <body>
        <div class="ui fixed inverted menu">
            <div class="ui container">
                <div class="header item"><i class="code icon nav"></i>Complaint Portal</div>
                <a href="landing.jsp" class="item"><i class="home icon nav"></i>Home</a>
                <a  style="position:absolute;left:90%" href="logout.jsp" class="item">Logout<i style="margin-left: 2px;size:2 em;"class="sign out alternate icon nav"></i></a>
            </div>
        </div> 


<div class="ui main text container segment">
    <div class="ui huge header center aligned">Synopsis</div>

  	<table class="ui celled table">
  <thead>
    <tr><th>Status</th>
    <th>Detail</th>
    <th>Date and Time</th>
  </tr></thead>
  <tbody>
  
   <%      
    String complaintid=request.getParameter("complaintid");
    Configuration cfg=new Configuration();
    cfg.configure("Hibernate.cfg.xml");
    System.out.println("Loaded Configuration .........");
    
    SessionFactory sf=cfg.buildSessionFactory();
    System.out.println("Loaded SessionFactory ..........");
    
    Session s=sf.openSession();
    System.out.println("Loaded Session ..........");
    
    
      Transaction t = s.beginTransaction();
            
      Query q= s.createSQLQuery("select status,comments,datetime from history where complaintid=?");
      q.setParameter(0,complaintid);
      List l = q.list();
      Iterator it = l.iterator();
      
      
      while(it.hasNext())
      {
      		Object obj[]=(Object[])it.next();
    	
      	%>
      		<tr>
          <td><%= obj[0]%></td>
          <td><%= obj[1]%></td>
          <td><%= obj[2]%></td>
        </tr>
      <% }
      t.commit();
      
      s.close();
      sf.close();
      
      
      %>
    
    
  </tbody>
  	</table>
</div>


    </body>
    </html>