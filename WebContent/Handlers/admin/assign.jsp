<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.util.Iterator,java.util.List,org.hibernate.*,org.hibernate.cfg.*,history.hist_model,java.util.Date,java.text.SimpleDateFormat" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<% String st=request.getParameter("name"); 
String complaintid=(String)request.getParameter("complaintid");
String hname="";

Configuration cfg=new Configuration();
cfg.configure("Hibernate.cfg.xml");
System.out.println("Loaded Configuration .........");

SessionFactory sf=cfg.buildSessionFactory();
System.out.println("Loaded SessionFactory ..........");

Session s=sf.openSession();
System.out.println("Loaded Session ..........");

Query q= s.createSQLQuery("update complaint set currently_assigned=?,status=? where complaintid=?");
q.setParameter(0, st);
q.setParameter(1,"Assigned");
q.setParameter(2,complaintid);
q.executeUpdate();
Transaction t = s.beginTransaction();
t.commit();

q= s.createSQLQuery("select name from handlers where id=?");
q.setParameter(0, st);
List l=q.list();
Iterator it=l.iterator();

if(it.hasNext()){
	Object obj=(Object)it.next();
	hname=(String)obj;
}

hist_model h = new hist_model();
 h.setComplaintId(Integer.parseInt(complaintid));
 h.setStatus("Assigned");
 SimpleDateFormat localDateFormat = new SimpleDateFormat("HH:mm:ss");
 String time = localDateFormat.format(new Date());
 h.setDatetime(java.sql.Date.valueOf(java.time.LocalDate.now())+" "+time);
 h.setComments("Complaint assigned to: "+hname);
 s.save(h);
Transaction ta = s.beginTransaction();
ta.commit();

response.sendRedirect("chat_stat.jsp?complaintid="+complaintid);

%>

</body>
</html>