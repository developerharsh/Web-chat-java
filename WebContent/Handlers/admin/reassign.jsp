<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.util.Iterator,java.util.List,org.hibernate.*,org.hibernate.cfg.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<% String st=request.getParameter("name"); 
   String reason=request.getParameter("reason"); 

String complaintid=(String)request.getParameter("complaintid");

Configuration cfg=new Configuration();
cfg.configure("Hibernate.cfg.xml");
System.out.println("Loaded Configuration .........");

SessionFactory sf=cfg.buildSessionFactory();
System.out.println("Loaded SessionFactory ..........");

Session s=sf.openSession();
System.out.println("Loaded Session ..........");

Query q= s.createSQLQuery("update complaint set currently_assigned=?,status=?");
q.setParameter(0, st);
q.setParameter(1,"Assigned");
q.executeUpdate();
Transaction t = s.beginTransaction();
t.commit();

 q= s.createSQLQuery("update history set currently_assigned=?,status=?");
q.setParameter(0, st);
q.setParameter(1,"Assigned");
q.executeUpdate();
Transaction ta = s.beginTransaction();
ta.commit();

response.sendRedirect("chat_stat.jsp?complaintid="+complaintid);

%>

</body>
</html>