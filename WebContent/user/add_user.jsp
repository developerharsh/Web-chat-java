<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.util.Iterator,java.util.List,org.hibernate.*,org.hibernate.cfg.*,java.math.BigDecimal,userLogin.*" %>
	<%! Integer comp_id=0; 
	BigDecimal userid;%>
    <%      
    String name=request.getParameter("name");
    String password=request.getParameter("password");
    Configuration cfg=new Configuration();
    cfg.configure("Hibernate.cfg.xml");
    System.out.println("Loaded Configuration .........");
    
    SessionFactory sf=cfg.buildSessionFactory();
    System.out.println("Loaded SessionFactory ..........");
    
    Session s=sf.openSession();
    System.out.println("Loaded Session ..........");
    
    
      Transaction ta1 = s.beginTransaction();
            
      Query q= s.createSQLQuery("select * from generate");
      List l = q.list();
      Iterator it = l.iterator();
      
      
      if(it.hasNext())
      {
      	BigDecimal st = (BigDecimal)it.next();
      	comp_id=st.intValue();
      	userid=st;
      	System.out.println("hey");
      	q=s.createSQLQuery("update generate set getnumber=getnumber+1 where getnumber=?");
      	q.setParameter(0, comp_id);
      	q.executeUpdate();
      }
      ta1.commit();
      
      Transaction t = s.beginTransaction();
      UserLogin p = new UserLogin();
      p.setPassword(password);
      p.setUserName(name);
      p.setUserId(comp_id);
      s.save(p);
      t.commit();
      

      s.close();
      sf.close();
      
      response.sendRedirect("user_landing.jsp");
	    session.setAttribute("userid",userid);
      
      %>