<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.io.*,java.util.*, javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*,history.hist_model" %>
<%@ page import="org.apache.commons.io.output.*,java.math.BigDecimal" %>
<%@page import="java.util.Iterator,java.util.List,org.hibernate.*,org.hibernate.cfg.*,java.util.Date,java.text.SimpleDateFormat,message.msg_model" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<%! String data[]=new String[4]; 
	Integer createdFileName;
	String savedFileName="null";
	String st;
	
	String userid="",recieverid="";
%>

<% 
String complaintid=(String)request.getParameter("complaintid");
Configuration cfg=new Configuration();
cfg.configure("Hibernate.cfg.xml");
System.out.println("Loaded Configuration .........");

SessionFactory sf=cfg.buildSessionFactory();
System.out.println("Loaded SessionFactory ..........");

Session s=sf.openSession();
System.out.println("Loaded Session ..........");



DiskFileItemFactory factory = new DiskFileItemFactory();

File file ;
// Set factory constraints
factory.setSizeThreshold(500000);
factory.setRepository(new File("../temp/"));

// Create a new file upload handler
ServletFileUpload upload = new ServletFileUpload(factory);

// Set overall request size constraint
upload.setSizeMax(5000000);

// Parse the request
List<FileItem> items = upload.parseRequest(request);

Iterator<FileItem> iter = items.iterator();
while (iter.hasNext()) {
    FileItem fi = iter.next();

    if (fi.isFormField()) {}
    else {
	  String fieldName = fi.getFieldName();
      String fileName = fi.getName();
      char[] str=fileName.toCharArray();
      int flag=0,i;
      for(i=0;i<str.length;i++)
      {
    	  if(str[i]=='.'){
    		break;
    	  }
    	 
      }
      if(fileName!=""){
      Query q= s.createSQLQuery("select * from generate");
      List l = q.list();
      Iterator it = l.iterator();
      	 
      if(it.hasNext())
      {
      	Integer st = ((BigDecimal)it.next()).intValue();
      	createdFileName=st;
      	q=s.createSQLQuery("update generate set getnumber=getnumber+1 where getnumber=?");
      	q.setParameter(0, createdFileName);
      	q.executeUpdate();
      }

      else{
    	  createdFileName=000000;
      }
      String abc= fileName.substring(i, fileName.length());
      out.println(abc);
      boolean isInMemory = fi.isInMemory();
      long sizeInBytes = fi.getSize();
      savedFileName=createdFileName+abc;
      file = new File( "G:\\" + savedFileName) ;
      fi.write( file ) ;
      out.println("Uploaded Filename: " + fileName + "<br>");
      
      }
      
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

      
      msg_model m = new msg_model();
      	
      m.setComplaintid(complaintid);
  	m.setAttachments(savedFileName);
   SimpleDateFormat localDateFormat = new SimpleDateFormat("HH:mm:ss");
   String time = localDateFormat.format(new Date());
   m.setDatetime(java.sql.Date.valueOf(java.time.LocalDate.now())+" "+time);
   m.setSender(userid);
   m.setReciever(recieverid);
   s.save(m);
  Transaction ta = s.beginTransaction();
  ta.commit();
      	
     


      System.out.println("Loaded Transaction .........");

     

      
    }
}

%>

<%
Query q= s.createSQLQuery("select complaintid from complaint where datetime=?");
q.setParameter(0, st);
List l = q.list();
Iterator it = l.iterator();
Integer comp_id=0;
if(it.hasNext())
{
	comp_id = ((BigDecimal)it.next()).intValue();
	
}

hist_model h= new hist_model();
h.setComplaintId(comp_id);
h.setDatetime(st);
h.setStatus("new");

s.save(h);
System.out.println(comp_id);
Transaction t = s.beginTransaction();
t.commit();
s.close();
sf.close();
response.sendRedirect("user_chat.jsp?complaintid="+complaintid); %>



</body>
</html>