<%@page import="java.math.BigDecimal"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.util.Iterator,java.util.List,org.hibernate.*,org.hibernate.cfg.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
    <%Object vali=session.getAttribute("id");
 	if(vali==null){
 		response.sendRedirect("../signin.jsp");
 	}
 	else{   
    
    String filter=request.getParameter("filter");
    	System.out.println(filter);
    	String query="";
    	Integer userid=((BigDecimal)session.getAttribute("id")).intValue();
    %>
        <title>Landing page</title>
        <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.3.1/semantic.min.css">
        <link rel="stylesheet" type="text/css" href="nalanding.css">
            
    </head>

    <body>
        <div class="ui fixed inverted menu">
            <div class="ui container">
                <div class="header item"><i class="code icon"></i>Complaint Portal</div>
                <a href="landing.jsp" class="item"><i class="home icon"></i>Home</a>
                <a  style="position:absolute;left:90%" href="logout.jsp" class="item">Logout<i style="margin-left: 2px;size:2 em;"class="sign out alternate icon"></i></a>
            </div>
        </div> 
        <% 
        
        Configuration cfg=new Configuration();
	cfg.configure("Hibernate.cfg.xml");
	System.out.println("Loaded Configuration .........");

	SessionFactory sf=cfg.buildSessionFactory();
	System.out.println("Loaded SessionFactory ..........");

	Session s=sf.openSession();
	System.out.println("Loaded Session ..........");
	
	//Integer userid=((BigDecimal)session.getAttribute("userid")).intValue();
	if(filter==null || filter.equals("none")){
		query="select subject,status,complaintid,datetime from complaint where currently_assigned="+userid;
	}else{
		query="select subject,status,complaintid,datetime from complaint where currently_assigned="+userid+" and status='"+filter+"'";	
	}
	Query q= s.createSQLQuery(query);
	List l = q.list();
	Iterator it = l.iterator();
	%>
		 
        


<div class="ui main text container">
  <div class="top">
    <div class="ui huge header">Welcome User</div>

    <div class="abc">
      <div class="ui horizontal text menu">
        <div class="header item">Filter By</div>
          
          <a href="landing.jsp?filter=none" class="active item">
             None
          </a>
          <a href="landing.jsp?filter=New" class="item">
             New
          </a>
  <a href="landing.jsp?filter=Assigned" class="item">
    Assigned
  </a>
  <a href="landing.jsp?filter=Reassign" class="item">
    Reassigned
  </a>
  <a href="landing.jsp?filter=Rejected" class="item">
    Rejected
  </a>
  <a href="landing.jsp?filter=Completed" class="item">
    Completed
  </a>
</div>
</div></div>
  

  
    
    <% while(it.hasNext())
	{
		Object st[] = (Object[])it.next();%>
		<div class="ui top attached segment">
        <div class="ui divided items">
        <%if(st[1].equals("Completed")){%>
        	<a href="chat.jsp?complaintid=<%=st[2]%>" class="completed"><strong>Subject: </strong><%= st[0] %></a>
            <i class="check icon completed"></i>
            <p><strong>Status: </strong><%= st[1] %><strong style="padding-left: 2%">Created on: </strong><%= st[3] %></p>
        	
        <% }else if(st[1].equals("Rejected")){ %>
        	<a href="chat.jsp?complaintid=<%=st[2]%>" class="rejected"><strong>Subject: </strong><%= st[0] %></a>
            <i class="unlink icon rejected"></i></i>
            <p><strong>Status: </strong><%= st[1] %><strong style="padding-left: 2%">Created on: </strong><%= st[3] %></p>
        	
        	
       <% }else{%>
    	   <a href="chat.jsp?complaintid=<%=st[2]%>"><strong>Subject: </strong><%= st[0] %></a>
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
</div>

    </body>
    </html>