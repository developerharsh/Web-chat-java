
<%@ page import="java.io.*,java.util.*, javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*,history.hist_model" %>
<%@ page import="org.apache.commons.io.output.*,java.math.BigDecimal,java.sql.Blob,javax.sql.rowset.serial.SerialBlob" %>
<%@page import="java.util.Iterator,java.util.List,org.hibernate.*,org.hibernate.cfg.*,java.util.Date,java.text.SimpleDateFormat,complaint.complaint_model" %>
<%! String data[]=new String[5]; 
	Integer createdFileName;
	String savedFileName="null";
	byte byt[];
	Blob blob;
	String st;
	Integer comp_id=0;%>
<% 

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
int j=0;
while (iter.hasNext()) {
    FileItem fi = iter.next();

    if (fi.isFormField()) {
    	String value = fi.getString();
    	data[j]=value;j++;%>
    	<% System.out.println(value); %>
    	
  <%  } else {
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
      //out.println(abc);
      //boolean isInMemory = fi.isInMemory();
      long sizeInBytes = fi.getSize();
      savedFileName=createdFileName+abc;
      byt=fi.get();
      blob=new SerialBlob(byt);
      //System.out.println(byt);
      //file = new File( "G:\\" + savedFileName) ;
      //fi.write( file ) ;
      //out.println("Uploaded Filename: " + fileName + "<br>");
      
      }
      
      complaint_model p = new complaint_model();
      Transaction ta1 = s.beginTransaction();
      

      
      Query q= s.createSQLQuery("select * from generate");
      List l = q.list();
      Iterator it = l.iterator();
      
      if(it.hasNext())
      {
      	Integer st = ((BigDecimal)it.next()).intValue();
      	comp_id=st;
      	q=s.createSQLQuery("update generate set getnumber=getnumber+1 where getnumber=?");
      	q.setParameter(0, comp_id);
      	q.executeUpdate();
      }
      ta1.commit();	
      	p.setAttachments(blob);
      	p.setAtt_name(savedFileName);
      	SimpleDateFormat localDateFormat = new SimpleDateFormat("HH:mm:ss");
          String time = localDateFormat.format(new Date());
      		//System.out.println(time);
        System.out.println(java.sql.Date.valueOf(java.time.LocalDate.now())+" "+time);
      	p.setDateTime(java.sql.Date.valueOf(java.time.LocalDate.now())+" "+time);
      	st=java.sql.Date.valueOf(java.time.LocalDate.now())+" "+time;
      	p.setModule(data[4]);
      	p.setPriority(data[3]);
      	p.setStatus("New");
      	p.setSubject(data[0]);
      	p.setType(data[2]);
      	p.setDescription(data[1]);
      	p.setComplaintId(comp_id);
      	Integer userid=((BigDecimal)session.getAttribute("userid")).intValue();
      	p.setUserId(userid);
      	s.save(p);
      	Transaction t = s.beginTransaction();
      	t.commit();

     


      System.out.println("Loaded Transaction .........");

     

      
    }
}

%>

<%
/*Query q= s.createSQLQuery("select complaintid from complaint where datetime=?");
q.setParameter(0, st);
List l = q.list();
Iterator it = l.iterator();
Integer comp_id=0;
if(it.hasNext())
{
	comp_id = ((BigDecimal)it.next()).intValue();
	
}*/

hist_model h= new hist_model();
h.setComplaintId(comp_id);
h.setDatetime(st);
h.setStatus("new");
h.setComments("Complaint introduced");

s.save(h);
System.out.println(comp_id);
Transaction t = s.beginTransaction();
t.commit();
s.close();
sf.close();
response.sendRedirect("user_chat.jsp?complaintid="+comp_id); %>

