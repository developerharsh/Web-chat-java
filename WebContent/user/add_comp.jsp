
<%@ page import="java.io.*,java.util.*, javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>
<%@ page import="org.apache.commons.io.output.*" %>
<%! String data[]=new String[4]; %>
<%  DiskFileItemFactory factory = new DiskFileItemFactory();

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
    	<%= value %>
    	
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
      String abc= fileName.substring(i, fileName.length());
      out.println(abc);
      boolean isInMemory = fi.isInMemory();
      long sizeInBytes = fi.getSize();
      file = new File( "G:\\" + "fileName"+abc) ;
      fi.write( file ) ;
      out.println("Uploaded Filename: " + fileName + "<br>");
      
      for(i=0;i<data.length;i++){
    	  System.out.println(data[i]);
      }
    }
}

%>



