<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.util.Iterator,java.math.*,java.util.List,org.hibernate.*,org.hibernate.cfg.*,java.util.Date,java.text.SimpleDateFormat,history.hist_model" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<% 
String complaintid=(String)request.getParameter("complaintid");

Configuration cfg=new Configuration();
cfg.configure("Hibernate.cfg.xml");
System.out.println("Loaded Configuration .........");

SessionFactory sf=cfg.buildSessionFactory();
System.out.println("Loaded SessionFactory ..........");

Session s=sf.openSession();
System.out.println("Loaded Session ..........");

Query q= s.createSQLQuery("update complaint set status=? where complaintid=?");
q.setParameter(0,"Reassigned");
q.setParameter(1,complaintid);
q.executeUpdate();
Transaction t = s.beginTransaction();
t.commit();

hist_model h = new hist_model();
h.setComplaintId(Integer.parseInt(complaintid));
h.setStatus("Reassigned");
h.setComments("Reassign request made");
SimpleDateFormat localDateFormat = new SimpleDateFormat("HH:mm:ss");
String time = localDateFormat.format(new Date());
h.setDatetime(java.sql.Date.valueOf(java.time.LocalDate.now())+" "+time);
s.save(h);
Transaction ta = s.beginTransaction();
ta.commit();
Integer userid=((BigDecimal)session.getAttribute("id")).intValue();
response.sendRedirect("landing.jsp");

%>


</body>
</html>