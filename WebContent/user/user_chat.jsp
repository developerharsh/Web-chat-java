<html>
    <head>
        <title> Signup</title>
        <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.3.1/semantic.min.css">
        <link rel="stylesheet" type="text/css" href="user_chat.css">

    </head>

    <body>
    <% String complaintid=(String)request.getParameter("complaintid"); %>
        <!-- <div class="ui fixed inverted menu">
            <div class="ui container">
                <div class="header item"><i class="code icon"></i>Blog Site</div>
                <a href="/" class="item">Home</a>
                <a href="/blogs/new" class="item">New Post</a>
            </div>
        </div> -->


<div class="ui main text container segment">
    <div class="ui huge header center aligned">Chat</div>


    <div class="ui top attached segment">
        <div class="ui divided items">
          <div class="recieved" >
          <p>my first message jdha adahdia jash</p>
          <a href=""><i class="download icon"></i> download</a>
          </div>

          <div class="send">
            <p>my sjdjos sdishd fudhf ejdneu absu ad a dj sfubfjdbfj kdfskf skdjbfsdfs djf</p>
            <a href=""><i class="download icon"></i> download</a>
          </div>
        </div>
    </div>


    <form class="ui form" method="POST" action="add_msg.jsp?complaintid=<%=complaintid%>">
     
  <div class="field">
    <div class="ui action input">
      <input type="text" placeholder="Text..." name="text">
      <button class="ui button" type="submit">Send</button>
</div>
  </div>
<!-- <button class="positive ui button" type="submit">Close chat</button> -->
    </form>
    <form class="ui form" method="POST"  enctype="multipart/form-data" action="add_att.jsp?complaintid=<%=complaintid%>">
     
  <div class="field">
    <div class="ui action input">
      <input type="file" name="filename">
      <input style="display:none" type="text" name="demo">
      <button class="ui button" type="submit">Send</button>
</div>
  </div>

    </form>

    <form class="ui form" method="POST" action="satisfied.jsp?complaintid=<%=complaintid%>">
      <button class="positive ui button" type="submit">Satisfied</button>
    </form>
</div>


    </body>
    </html>