<html>
    <head>
        <title> New complaint</title>
        <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.3.1/semantic.min.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.3.1/semantic.min.js"></script>
            
    </head>


    <body>
        <!-- <div class="ui fixed inverted menu">
            <div class="ui container">
                <div class="header item"><i class="code icon"></i>Blog Site</div>
                <a href="/" class="item">Home</a>
                <a href="/blogs/new" class="item">New Post</a>
            </div>
        </div> -->


<div class="ui main text container segment" style="margin-top: 100px">
    <div class="ui huge header center aligned">New Complaint</div>

    <form class="ui form" method="POST">
       

  <div class="field">
    <label>Subject</label>
    <input type="text" name="subject" placeholder="Subject goes here ...">
  </div>

  <div class="field">
     <div class="ui selection dropdown">
  <input type="hidden" name="Type">
  <i class="dropdown icon"></i>
  <div class="default text">Type</div>
  <div class="menu">
    <div class="item" data-value="1">Bug</div>
    <div class="item" data-value="0">Suggestion</div>
    <div class="item" data-value="2">New request</div>
  </div>
</div>
  </div>

  <div class="field">
     <div class="ui selection dropdown">
  <input type="hidden" name="Priority">
  <i class="dropdown icon"></i>
  <div class="default text">Priority</div>
  <div class="menu">
    <div class="item" data-value="1">High</div>
    <div class="item" data-value="0">Medium</div>
    <div class="item" data-value="2">Low</div>
  </div>
</div>
  </div>

  <div class="field">
     <div class="ui selection dropdown">
  <input type="hidden" name="Module">
  <i class="dropdown icon"></i>
  <div class="default text">Module</div>
  <div class="menu">
    <div class="item" data-value="1">IT</div>
    <div class="item" data-value="0">Electrical</div>
    <div class="item" data-value="2">Mechannical</div>
  </div>
</div>
  </div>

  <div class="field">
    <label>Attachments:</label>
    <input type="file" name="filename">
    
  </div>
  <br>
  <button class="ui button" type="submit">Submit</button>
    </form>
</div>
<script>
    $('.ui.dropdown')
  .dropdown()
;
</script>


    </body>
    </html>