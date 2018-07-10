<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
    	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title> Signin</title>
        <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.3.1/semantic.min.css">
        <link rel="stylesheet" type="text/css" href="signin.css">
    </head>

    <body>
         <div class="ui fixed inverted menu">
            <div class="ui container">
                <div class="header item"><i class="code icon"></i>Complaint Portal</div>
                <a href="index.jsp" class="item"><i class="home icon"></i>Home</a>
                <a  style="position:absolute;left:90%" href="index.jsp" class="item">Logout<i style="margin-left: 2px;size:2 em;"class="sign out alternate icon"></i></a>
            </div>
        </div> 
        


<div class="ui main text container segment">
    <div class="ui huge header center aligned">Sign-in/<a href="./user/user_signup.jsp">Sign-up</a></div>

    <form class="ui form" method="POST" action="validate.jsp">
        <div class="field">
 
    <label>User Name</label>
    <input type="text" name="username" placeholder="User Name">
  </div>


  <div class="field">
    <label>Password</label>
    <input type="text" name="password" placeholder="Password">
  </div>
  

  <button class="ui button" type="submit">Sign-in</button>
    </form>
</div>


    </body>
    </html>