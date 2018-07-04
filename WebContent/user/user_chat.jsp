<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.util.Iterator,java.util.List,org.hibernate.*,org.hibernate.cfg.*,java.math.BigDecimal,java.util.Date,java.text.SimpleDateFormat" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <title> Signup</title>
        <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.3.1/semantic.min.css">
        <link rel="stylesheet" type="text/css" href="usr_chat.css">

    </head>

    <body>
    
    <%
    Object vali=session.getAttribute("userid");
    String complaintid=(String)request.getParameter("complaintid");
    if(vali==null){
		response.sendRedirect("user_signin.jsp");
	}
	else{
    
    Integer userid=((BigDecimal)session.getAttribute("userid")).intValue();
    String id=userid.toString();%>
       <div class="ui fixed inverted menu">
            <div class="ui container">
                <div class="header item"><i class="code icon nav"></i>Complaint Portal</div>
                <a href="user_landing.jsp" class="item"><i class="home icon nav"></i>Home</a>
                <a  style="position:absolute;left:90%" href="logout.jsp" class="item">Logout<i style="margin-left: 2px;size:2 em;"class="sign out alternate icon nav"></i></a>
            </div>
        </div> 


<div class="ui main text container segment">
    <div class="ui huge header center aligned">Chat</div>

	<%  

Configuration cfg=new Configuration();
cfg.configure("Hibernate.cfg.xml");
System.out.println("Loaded Configuration .........");

SessionFactory sf=cfg.buildSessionFactory();
System.out.println("Loaded SessionFactory ..........");

Session s=sf.openSession();
System.out.println("Loaded Session ..........");

Query q1= s.createSQLQuery("select * from complaint where complaintid=? and userid=?");
q1.setParameter(0,complaintid);
q1.setParameter(1, id);
List l1 = q1.list();
Iterator it1 = l1.iterator();
	if(it1.hasNext()){
		

 Query q= s.createSQLQuery("select currently_assigned,subject from complaint where complaintid=?");
System.out.println(complaintid);
q.setParameter(0,complaintid);
List l = q.list();
Iterator it = l.iterator();
Object ab=null;
String subject="";
	if(it.hasNext()){
		Object st[]=(Object[])it.next();
		ab=st[0];
		subject=(String)st[1];
	}%>
	
	
	<p><strong>Subject:</strong><%=subject %></p>
	
	<% if(ab==null){%>
		<img src="../Resources/loading.gif" style="margin-left: 30%">
		<p style="padding-left: 14%">Please wait while we assign your complaint to someone </p>
		<img src="../Resources/loading_dots.gif" style="width:15%;position: absolute;left: 68%;top: 77.8%;">
	<% }else{

  q= s.createSQLQuery("select sender,attachments,text,sname from messages where complaintid=?");
 q.setParameter(0,complaintid);
 l = q.list();
 it = l.iterator();%>
 <div class="ui top attached segment" style="margin-top: 0px;">
        <div class="ui divided items">
<% while(it.hasNext())
{
	Object obj[] = (Object[])it.next();
	if(obj[0].equals(id))
	{%>	
		<div style="position: relative;max-width: 60%;left: 40%;">
		<p align="right" style="margin-bottom: 0px;font-size: 13px;margin-top: 8px;color: yellowgreen;"><i>You</i></p>
		<% if(obj[1]==null)
		{%> 
			<p align="right"><%=obj[2] %></p>
			
		<%}else{%>
		    
			<a style="position: relative;left:78%" href="download?attachment=<%=obj[1]%>"><i class="download icon"></i> download</a>
		<% }%>
		</div>
	<%}else{%>
		<div style="max-width: 60%;">
		<p style="margin-bottom: 0px;font-size: 13px;margin-top: 8px;color: peru;"><i><%=obj[3] %></i></p>
		<% if(obj[1]==null)
		{%>
			
			<p><%=obj[2] %></p>
			
		<%}else{%>
		
			<a href="download?attachment=<%=obj[1]%>"><i class="download icon"></i> download</a>
			<%} %>
			</div>
	<%}%>

<%}%></div></div>
<% q= s.createSQLQuery("select status from complaint where complaintid=?");
q.setParameter(0,complaintid);
 l = q.list();
it = l.iterator();
String status="";
	if(it.hasNext()){
		Object st=(Object)it.next();
		status=(String)st;
	}
    if(!(status.equals("Completed")||status.equals("Rejected"))){%>

    


    <form style="margin-top: 8px" class="ui form" method="POST" action="add_msg.jsp?complaintid=<%=complaintid%>">
     
  <div class="field">
    <div class="ui action input">
      <input type="text" placeholder="Text..." name="text">
      <button class="ui button" type="submit">Send</button>
</div>
  </div>
<!-- <button class="positive ui button" type="submit">Close chat</button> -->
    </form>
    <form style="margin-top: 4px" class="ui form" method="POST"  enctype="multipart/form-data" action="add_att.jsp?complaintid=<%=complaintid%>">
     
  <div class="field">
    <div class="ui action input">
      <input type="file" name="filename">
      <input style="display:none" type="text" name="demo">
      <button class="ui button" type="submit">Send</button>
</div>
  </div>

    </form>

    <form style="margin-top: 10px" class="ui form" method="POST" action="satisfied.jsp?complaintid=<%=complaintid%>">
      <button class="positive ui button" type="submit">Satisfied</button>
    </form><%}}}
	else{
		response.sendRedirect("user_landing.jsp");
	}
	s.close();
	sf.close();
	} %>
</div>


    </body>
    </html>