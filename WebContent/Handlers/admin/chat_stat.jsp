<%@page import="java.math.BigDecimal"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.util.Iterator,java.util.List,org.hibernate.*,org.hibernate.cfg.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<% String complaintid=(String)request.getParameter("complaintid");
	String subject="",attachments="",module="",type="",datetime="",priority="";
%>
<html>
    <head>
        <title> Signup</title>
        <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.3.1/semantic.min.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.3.1/semantic.min.js"></script>
        <link rel="stylesheet" type="text/css" href="chat_stat.css">
            
    </head>

    <body>
    
     <%  Configuration cfg=new Configuration();
	cfg.configure("Hibernate.cfg.xml");
	System.out.println("Loaded Configuration .........");

	SessionFactory sf=cfg.buildSessionFactory();
	System.out.println("Loaded SessionFactory ..........");

	Session s=sf.openSession();
	System.out.println("Loaded Session ..........");

	//Integer userid=((BigDecimal)session.getAttribute("userid")).intValue();
	Query q= s.createSQLQuery("select subject,attachments,module,type,priority,datetime from complaint where complaintid=?");
	q.setParameter(0, complaintid);
	List l = q.list();
	Iterator it = l.iterator();
	if(it.hasNext()){
		Object st[]= (Object[])it.next();
		subject=(String)st[0];
		attachments=(String)st[1];
		module=(String)st[2];
		type=(String)st[3];
		priority=(String)st[4];
		datetime=(String)st[5];
	}
	%>
	
	<%	
	
	s.close();
	sf.close();
%> 
<div class="outer">
<div class="ui main text container segment">

  <div class="ui huge header center aligned">Complaint</div>

  <p><strong style="padding-right: 2%">Subject:</strong><%=subject %></p>
  <p><strong style="padding-right: 2%">Module:</strong><%=module%></p>
  <p><strong style="padding-right: 2%">Type:</strong><%=type%></p>
  <p><strong style="padding-right: 2%">Priority:</strong><%=priority%></p>
  <p><strong style="padding-right: 2%">Date and time:</strong><%=datetime%></p>
<%if(attachments.equals("null")){}
	else{%>
  <div class="item"> 
    <div class="content"> 
      <div class="description"> 
        <p><strong>Attachments:</strong></p> 
      </div> 
    </div>
    <a href="download?attachment=<%=attachments%>"><img src="download.jpg"></a>
     
  </div>
  <% }%>
  
      <div class="ui grid">
  <div class="four wide column">
    <div class="ui vertical fluid tabular menu">
      <a class="item abc active" name="assign">
        Assign
      </a>
      <a class="item abc" name="reassign">
        Reassign
      </a>
      <a class="item abc" name="reject">
        Reject
      </a>
      <a class="item abc" name="completed">
        Resolved
      </a>
    </div>
  </div>
  <div class="twelve wide stretched column">
    <div class="ui segment">

      <div class="assign">
        <div class="ui huge header center aligned">Assign form</div>

        <form class="ui form" method="POST" action="assign.jsp">
              <div class="field"> 
                <label>Assign to: </label> 
                <select id="drop" class="ui selection dropdown"> 
                    <option value="">Name1</option> 
                    <option value="1">Name2</option>
                    <option value="0">Name3</option> 
                </select> 
                </div> 
                <button class="ui button" type="submit">Assign</button>
        </form>

      </div>

      <div class="reassign" style="display: none;">

        <div class="ui huge header center aligned">Reassign form</div>

        <p><strong>Previously assigned to:</strong> Name</p>

        <form class="ui form" method="POST">
              <div class="field"> 
                <label>Reassign to: </label> 
                <select id="drop" class="ui selection dropdown"> 
                    <option value="">Name1</option> 
                    <option value="1">Name2</option>
                    <option value="0">Name3</option> 
                </select> 
                </div> 

                <div class="field">
                  <label>Reason</label>
                  <input type="text" name="reason" placeholder="Reason">
                </div>
                <button class="ui button" type="submit">Reassign</button>
        </form>

      </div>
      <div class="reject" style="display: none;">

        <form class="ui form" method="POST">
          <div class="field">
                  <label>Reason</label>
                  <input type="text" name="reason" placeholder="Reason">
          </div>
          <div class="center"> <button class="negative ui button">Reject</button></div>
        </form>

      </div>
      
      <div class="completed" style="display: none;">
        <h3 style="color: green">The complaint was resolved.</h3>
        <img style="-webkit-max-logical-height: 100px;" src="https://images-na.ssl-images-amazon.com/images/I/51zLZbEVSTL._SY355_.jpg">
      </div>
    </div>
  </div>
</div>
</div>
</div>
<script>
  $('.abc').on("click",function(){
    $('.abc').removeClass("active");
    $(this).addClass("active");
    var type= $(this).attr("name");
    if(type === "assign"){
         $(".assign").fadeIn(1000);
        $(".reassign").css("display","none");
        $(".reject").css("display","none");
        $(".completed").css("display","none");
    }
    else if(type === "reassign"){
        $(".assign").css("display","none");
        $(".reassign").fadeIn(1000);
        $(".reject").css("display","none");
        $(".completed").css("display","none");
    }
    else if(type === "reject"){
        $(".assign").css("display","none");
        $(".reassign").css("display","none");
        $(".reject").fadeIn(1000);
        $(".completed").css("display","none");
    }

    else if(type === "completed"){
        $(".assign").css("display","none");
        $(".reassign").css("display","none");
        $(".reject").css("display","none");
        $(".completed").fadeIn(1000);
    }
  });
  $('#drop').dropdown();
</script>



    </body>
    </html>