<%@page import="java.math.BigDecimal"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.util.Iterator,java.util.List,org.hibernate.*,org.hibernate.cfg.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

    <head>
        <title>Landing page</title>
        <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.3.1/semantic.min.css">
        <link rel="stylesheet" type="text/css" href="usr_landing.css">
            
    </head>

    <body>
        <div class="ui fixed inverted menu">
            <div class="ui container">
                <div class="header item"><i class="code icon"></i>Complaint Portal</div>
                <a href="user_landing.jsp" class="item"><i class="home icon"></i>Home</a>
                <a  style="position:absolute;left:90%" href="logout.jsp" class="item">Logout<i style="margin-left: 2px;size:2 em;"class="sign out alternate icon"></i></a>
            </div>
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

	Integer userid=((BigDecimal)session.getAttribute("userid")).intValue();
	Query q= s.createSQLQuery("select subject,status,complaintid,datetime from complaint where userid=?");
	q.setParameter(0, userid);
	List l = q.list();
	Iterator it = l.iterator();
	%>
		 


<div class="ui main text container">
  <div class="top">
    <div class="ui huge header">Welcome User</div>

  </div>
  
    <% while(it.hasNext())
	{
		Object st[] = (Object[])it.next();%>
		<div class="ui top attached segment">
        <div class="ui divided items">
        <%if(st[1].equals("Completed")){%>
        	<a href="user_chat.jsp?complaintid=<%=st[2]%>" class="completed"><strong>Subject: </strong><%= st[0] %></a>
            <i class="check icon completed"></i>
            <p><strong>Status: </strong><%= st[1] %><strong style="padding-left: 2%">Created on: </strong><%= st[3] %></p>
        	
        	<% }else if(st[1].equals("Rejected")){ %>
        	<a href="user_chat.jsp?complaintid=<%=st[2]%>" class="rejected"><strong>Subject: </strong><%= st[0] %></a>
            <i class="unlink icon rejected"></i></i>
            <p><strong>Status: </strong><%= st[1] %><strong style="padding-left: 2%">Created on: </strong><%= st[3] %></p>
        	
        	
       <% }else{%>
    	   <a href="user_chat.jsp?complaintid=<%=st[2]%>"><strong>Subject: </strong><%= st[0] %></a>
            <i class="edit icon"></i>
            <p><strong>Status: </strong><%= st[1] %><strong style="padding-left: 2%">Created on: </strong><%= st[3] %></p>
       <% } %>
          
        </div>
    </div>
		
	<%	System.out.println(st[0]);
	}
	

	s.close();
	sf.close();
	}
%>    
    
    <br>
    <a  href="new_comp.jsp" id="new"> New Complaint<i class="pencil alternate icon" id="exc"></i></a>
  
</div>

    </body>
    </html>