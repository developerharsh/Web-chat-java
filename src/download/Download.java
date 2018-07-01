package download;


import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
 
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 




public class Download extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		String file=(String)request.getParameter("attachment");
		System.out.println(file);
		PrintWriter out = response.getWriter();
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
		out.close();
	}
 
 
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}
 
}

