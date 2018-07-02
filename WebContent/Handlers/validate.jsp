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

<%
	String userid=request.getParameter("username");
	String password=request.getParameter("password");
	
	
	Configuration cfg=new Configuration();
	cfg.configure("Hibernate.cfg.xml");
	System.out.println("Loaded Configuration .........");

	SessionFactory sf=cfg.buildSessionFactory();
	System.out.println("Loaded SessionFactory ..........");

	Session s=sf.openSession();
	System.out.println("Loaded Session ..........");

	Query q= s.createSQLQuery("select * from handlers where name=? and password=?");
	q.setParameter(0, userid);
	q.setParameter(1, password);
	List l = q.list();
	Iterator it = l.iterator();
		 
	if(it.hasNext())
	{
		Object st[] = (Object[])it.next();
		session.setAttribute("id",st[0]);
		if(st[4].equals("yes")){
			response.sendRedirect("./admin/landing.jsp");
		}else{
			response.sendRedirect("./non-admin/landing.jsp");
		}
	}
	
	else{
		response.sendRedirect("../index.jsp");
	}

	
	 //   status p = new status();
	//   p.setSname("new");
	//   s.save(p);
	//   Transaction t = s.beginTransaction();
	//   t.commit();
	//
	System.out.println("Loaded Transaction .........");

	s.close();
	sf.close();
	
	
%>

</body>
</html>