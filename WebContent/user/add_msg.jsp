<%@page import="java.math.BigDecimal"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.util.Iterator,java.util.List,org.hibernate.*,org.hibernate.cfg.*,message.msg_model,java.util.Date,java.text.SimpleDateFormat" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<% String st=request.getParameter("text"); 
String complaintid=(String)request.getParameter("complaintid");
String userid="",recieverid="",name="";

if(!st.equals("")){

Configuration cfg=new Configuration();
cfg.configure("Hibernate.cfg.xml");
System.out.println("Loaded Configuration .........");

SessionFactory sf=cfg.buildSessionFactory();
System.out.println("Loaded SessionFactory ..........");

Session s=sf.openSession();
System.out.println("Loaded Session ..........");

Query q= s.createSQLQuery("update complaint set status=? where complaintid=?");
q.setParameter(0,"Query");
q.setParameter(1,complaintid);
q.executeUpdate();
Transaction t = s.beginTransaction();
t.commit();

 q= s.createSQLQuery("select userid,currently_assigned from complaint where complaintid=?");
 q.setParameter(0,complaintid);
 List l = q.list();
Iterator it = l.iterator();
if(it.hasNext())
{
	Object obj[] = (Object[])it.next();
	userid=((BigDecimal)obj[0]).toPlainString();
	recieverid=((BigDecimal)obj[1]).toPlainString();
}

q= s.createSQLQuery("select username from userlogin where userid=?");
q.setParameter(0,userid);
 l = q.list();
 it = l.iterator();
if(it.hasNext())
{
	Object obj = (Object)it.next();
	name=(String)obj;
}

msg_model m = new msg_model();
	m.setComplaintid(complaintid);
	m.setText(st);
 SimpleDateFormat localDateFormat = new SimpleDateFormat("HH:mm:ss");
 String time = localDateFormat.format(new Date());
 m.setDatetime(java.sql.Date.valueOf(java.time.LocalDate.now())+" "+time);
 m.setSender(userid);
 m.setSname(name);
 m.setReciever(recieverid);
 s.save(m);
Transaction ta = s.beginTransaction();
ta.commit();

s.close();
sf.close();


}
response.sendRedirect("user_chat.jsp?complaintid="+complaintid);

%>

</body>
</html>