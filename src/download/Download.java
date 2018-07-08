package download;


import java.io.ByteArrayInputStream;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.sql.Blob;
import java.sql.SQLException;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;
 




public class Download extends HttpServlet {
	byte byt[];
	String fileName;
	Blob b;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		
		Configuration cfg=new Configuration();
		cfg.configure("Hibernate.cfg.xml");
		System.out.println("Loaded Configuration .........");

		SessionFactory sf=cfg.buildSessionFactory();
		System.out.println("Loaded SessionFactory ..........");

		Session s=sf.openSession();
		System.out.println("Loaded Session ..........");
		
		Query q=s.createSQLQuery("select attachments,att_name from messages where count=234");
		List l=q.list();
		Iterator it = l.iterator();
		
		if(it.hasNext()){
			Object obj[]=(Object[])it.next();
			 b=(Blob)obj[0];
			fileName=(String)obj[1];
		}
		
		String contentType = this.getServletContext().getMimeType(fileName);
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		response.setContentType("APPLICATION/OCTET-STREAM");
		response.setHeader("Content-Disposition", "attachment; filename=\""
				+ fileName + "\"");
		//String complaintid=(String)request.getParameter("complaintid");
		try{
        InputStream is = b.getBinaryStream();
		
		
		 // byte[] bytes = new byte[1024];
          int i;

          while ((i = is.read()) != -1) {
              // Write image data to Response.
        	  out.write(i);
          }
          is.close();
		}
		catch(Exception e){
			System.out.println(e);
		}
        
        
	/*	response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		
		//String file=(String)request.getParameter("attachment");
		String path = "G:\\";
		response.setContentType("APPLICATION/OCTET-STREAM");
		response.setHeader("Content-Disposition", "attachment; filename=\""
				+ "10047.PNG" + "\"");
 
		FileInputStream fileInputStream = new FileInputStream(path
				+ "10047.PNG");
 
		int i;
		while ((i = fileInputStream.read()) != -1) {
			out.write(i);
		}
		fileInputStream.close();
		out.close();*/
	}
 
 
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}
 
}

