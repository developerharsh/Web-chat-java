package download;


import java.io.ByteArrayInputStream;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;
 




public class Download extends HttpServlet {
	byte byt[];
	private static final int BUFFER_SIZE = 4096; 
	private static final long serialVersionUID = 1L;
 
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		InputStream sImage;
		String ct=request.getContextPath();
		
		PrintWriter out = response.getWriter();
		//String complaintid=(String)request.getParameter("complaintid");
		Configuration cfg=new Configuration();
		cfg.configure("Hibernate.cfg.xml");
		System.out.println("Loaded Configuration .........");

		SessionFactory sf=cfg.buildSessionFactory();
		System.out.println("Loaded SessionFactory ..........");

		Session s=sf.openSession();
		System.out.println("Loaded Session ..........");
		
		
		
		
		Query q=s.createSQLQuery("select attachments from messages where complaintid=10037");
		List l=q.list();
		Iterator it = l.iterator();
		
		if(it.hasNext()){
			byt=(byte[])it.next();
		}
		//System.out.println(byt);
		int size=0;
	    sImage = rs.getBinaryStream(1);
	    response.reset();
	    response.setContentType("image/jpeg");
	    while((size=sImage.read(byt))!= -1 )
	    {
	        response.getOutputStream().write(byt,0,size);
	    }
	   
        
        
        
        
		/*System.out.println(file);
		
		String file=(String)request.getParameter("attachment");
		String path = "G:\\";
		response.setContentType("APPLICATION/OCTET-STREAM");
		response.setHeader("Content-Disposition", "attachment; filename=\""
				+ file + "\"");
 
		FileInputStream fileInputStream = new FileInputStream(path
				+ file);
 
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

