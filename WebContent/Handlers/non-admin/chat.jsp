<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.util.Iterator,java.util.List,org.hibernate.*,org.hibernate.cfg.*,java.math.BigDecimal,java.util.Date,java.text.SimpleDateFormat" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <title> Signup</title>
        <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.3.1/semantic.min.css">
        <link rel="stylesheet" type="text/css" href="nachat.css">

    </head>

    <body>
    <% String complaintid=(String)request.getParameter("complaintid");
    Integer userid=((BigDecimal)session.getAttribute("id")).intValue();
    String id=userid.toString();%>
        <div class="ui fixed inverted menu">
            <div class="ui container">
                <div class="header item"><i class="code icon nav"></i>Complaint Portal</div>
                <a href="landing.jsp" class="item"><i class="home icon nav"></i>Home</a>
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

Query q= s.createSQLQuery("select subject from complaint where complaintid=?");
q.setParameter(0,complaintid);
List l = q.list();
Iterator it = l.iterator();
String subject="";
	if(it.hasNext()){
		Object st=(Object)it.next();
		subject=(String)st;
	}%>
	
	<p><strong>Subject:</strong><%=subject %></p>

 <%  q= s.createSQLQuery("select sender,attachments,text from messages where complaintid=?");
 q.setParameter(0,complaintid);
  l = q.list();
 it = l.iterator();%>
 <div class="ui top attached segment">
        <div class="ui divided items">
<% while(it.hasNext())
{
	Object obj[] = (Object[])it.next();
	if(obj[0].equals(id))
	{%>	
		<div style="position: relative;max-width: 60%;left: 40%;">
		<% if(obj[1]==null)
		{%>
			<p align="right"><%=obj[2] %></p>
			
		<%}else{%>
			<a style="position: relative;left:78%" href="download?attachment=<%=obj[1]%>"><i class="download icon"></i> download</a>
		<% }%>
		</div>
	<%}else{%>
		<div style="max-width: 60%;">
		<% if(obj[1]==null)
		{%>
			<p><%=obj[2] %></p>
			
		<%}else{%>
			<a href="download?attachment=<%=obj[1]%>"><i class="download icon"></i> download</a>
			<%} %>
			</div>
	<%}%>

<%}%>
</div></div>

    


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

    <form style="margin-top: 10px" class="ui form" method="POST" action="reassign.jsp?complaintid=<%=complaintid%>">
      <button class="positive ui button" type="submit">Reassign</button>
    </form>
</div>


    </body>
    </html>