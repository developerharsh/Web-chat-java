<html>
    <head>
        <title> Signup</title>
        <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.3.1/semantic.min.css">
        <link rel="stylesheet" type="text/css" href="usr_signup.css">
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js">
          $("#gen-sel").dropdown();
        </script>
            
    </head>

    <body>
        <div class="ui fixed inverted menu">
            <div class="ui container">
                <div class="header item"><i class="code icon"></i>Complaint Portal</div>
                <a href="user_landing.jsp" class="item"><i class="home icon"></i>Home</a>
                <a  style="position:absolute;left:90%" href="logout.jsp" class="item">Logout<i style="margin-left: 2px;size:2 em;"class="sign out alternate icon"></i></a>
            </div>
        </div> 


<div class="ui main text container segment">
    <div class="ui huge header center aligned">Sign-up/<a href="user_signin.jsp">Sign-in</a></div>

    <form class="ui form" method="POST" action="add_user.jsp">
        <div class="field">
    <label>User Name</label>
    <input type="text" name="name" placeholder="First Name">
  </div>

  <div class="field">
    <label>Password</label>
    <input type="text" name="password" placeholder="Password">
  </div>


  <button class="ui button" type="submit">Sign-up</button>
    </form>
</div>



    </body>
    </html>