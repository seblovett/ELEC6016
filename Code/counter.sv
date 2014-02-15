<!DOCTYPE HTML PUBLIC '-//W3C//DTD HTML 4.01 Transitional//EN' 'http://www.w3.org/TR/html4/loose.dtd'>
<html lang='en'>
<head>
  <title>ECS - ECS Intranet Login</title>
  <link rel='stylesheet' media='screen' href='https://secure.ecs.soton.ac.uk/style/css.php' type='text/css' >
  <link rel='stylesheet' media='screen' href='https://secure.ecs.soton.ac.uk/style/css/intranet.css' type='text/css' >
  <link rel='stylesheet' media='print' href='https://secure.ecs.soton.ac.uk/style/css.php?mode=print' type='text/css' >

  <script language='javascript' type='text/javascript' src='/tinymce/tiny_mce/tiny_mce.js'></script>
  <script language='javascript' type='text/javascript'>
tinyMCE.init({
	mode : 'textareas',
	theme : 'advanced',
	plugins : 'table,layer',
	theme_advanced_toolbar_location : 'top',
	theme_advanced_buttons1_add_before : 'cut,copy,paste,separator',
	theme_advanced_buttons3_add_before : 'tablecontrols,separator',
	editor_selector : 'mceEditor'
});
</script>
<script type='text/javascript'>
	var isSecure = true;
</script>
</head>
<body id="page_Login">
<div class='noPrint' id='header'>

<div id="title" style="margin: 0; padding: 0; "><table cellpadding="0" cellspacing="0" border="0" width="100%">
<tr><td align="left" valign="top" rowspan="2"><a href="http://www.ecs.soton.ac.uk/">
<img src="https://secure.ecs.soton.ac.uk/style/images/header/ecs_logo.gif" width="235" height="97" alt="Electronics and Computer Science - a school of the University of Southampton" border="0"/></a></td>
<td align="right" valign="top">
<table cellpadding="0" border="0" cellspacing="0"><tr><td>
  <div id="search" class="noPrint"> 
    <form action="https://secure.ecs.soton.ac.uk/gizmos/search.php">
      <table cellpadding="0" border="0" cellspacing="4"><tr style="vertical-align: top">
      <td><span class="label">
	  <img src="https://secure.ecs.soton.ac.uk/style/images/header/search.gif" width="10" height="10" alt="Search" />
      <label for="q">Search </label> 
      </span> </td>
<td>
      <input type="hidden" name="type" value="knowledgebase" />
      <input id="q" style="border:0px;padding:1px" name="q" type="text" value="Enter keywords here" onfocus="javascript:if (this.value=='Enter keywords here') this.value='';"/> <br/><a style="color: #eeeeee" href="/search/advanced/">Advanced search</a>
</td>
<td>
      <input name="s" value="1" type="hidden" />
      <input type="image" src="https://secure.ecs.soton.ac.uk/style/images/header/go.gif" alt="Start Search" /> 
</td>
</tr></table>
    </form>  
  </div> 
</td>

</tr></table>
</td>
</tr>
<tr>
<td valign="bottom" align="right" width="100%">
<ul class="ecsmenu">
<li style="margin-right:1em; border-right: solid 1px black;"><a href="http://www.ecs.soton.ac.uk/"><span>ECS Home</span></a><span class="hide"> |</span></li>
<li><a href="https://secure.ecs.soton.ac.uk/"><span>Intranet</span></a><span class="hide"> |</span></li>
<li><a href="https://secure.ecs.soton.ac.uk/community/"><span>ECS News Today</span></a><span class="hide"> |</span></li>
<li><a href="https://secure.ecs.soton.ac.uk/kb/"><span>Knowledgebase</span></a><span class="hide"> |</span></li>
<li><a href="https://secure.ecs.soton.ac.uk/myecs/"><span>MyECS</span></a><span class="hide"> |</span></li>
<li><a href="https://secure.ecs.soton.ac.uk/ug/"><span>UG &amp; MSc</span></a>
<li><a href="https://secure.ecs.soton.ac.uk/staff/"><span>Staff &amp; PG</span></a>
<li><a href="https://secure.ecs.soton.ac.uk/mail/"><span>Webmail</span></a>
</ul>
</td>
</tr></table>
</div>
<hr class="hide" /><div id='breadcrumbs' class='noPrint'><div class='login' style='float:right'><a href='https://secure.ecs.soton.ac.uk/login/?uri=%2Flogin%2F&amp;args=reason%3Dlogin%26uri%3D%252Fnotes%252Felec6016%252Ftjk1314%252Fassignment%252Fcounter.sv'>Login to ECS Intranet</a></div><span class='hide'>Breadcrumb trail: </span><ul>
<li><a href="http://www.soton.ac.uk/">University of Southampton</a> &gt; </li><li><a href="http://www.ecs.soton.ac.uk/">ECS</a> &gt; </li><li><a href="https://secure.ecs.soton.ac.uk/">Intranet</a> &gt; </li><li class="current">Login</li></ul></div>
</div><div id='content'>
<h1><span class='noScreen'>ECS Intranet:<br /></span>ECS Intranet Login</h1><div class='pageContentBars0'><hr class='hide' />
<a name='contentJump'></a>
<!-- Main Page Begins -->

<form action="https://secure.ecs.soton.ac.uk/login/now/index.php" method="POST" >
<table>
  <tr>
    <td style="text-align:right">Username:</td>
    <td><input style='border: solid 1px #888' id = 'ecslogin_username' name="ecslogin_username" /></td>
  </tr>
  <tr>
    <td style="text-align:right">Password:</td>
    <td><input style='border: solid 1px #888' name="ecslogin_password" type="password" /></td>
  </tr>
  <tr>
    <td></td>
    <td>
<div style='font-size:90%'><strong>Recent change:</strong> (Jan 2012) The default security option has changed to "any IP" to facilitate people on laptops and ipads etc. </div>
<div><label><input value='weak' checked='checked' type='radio' name='ecslogin_security' /> Login works from any IP Address (less secure)</label></div>
<div><label><input value='strong' type='radio' name='ecslogin_security' /> Login works from your current IP address only (more secure)</label></div>
</td>
  </tr>
  <tr>
    <td></td>
    <td>
      <input type="hidden" name="ecslogin_uri" value="/notes/elec6016/tjk1314/assignment/counter.sv" />
      <input type="hidden" name="ecslogin_args" value="" />
      <input type="submit" value="Log in...." />
    </td>
  </tr>
</table>
</form>

<script type="text/javascript">document.getElementById('ecslogin_username').focus()</script>
<br style='clear: both;' />
<!-- Main Page Ends -->
</div>
<br style='clear: both;' />
<hr /></div>

<div id="footer" class="noPrint"> 
<p><a href="https://secure.ecs.soton.ac.uk/cgi-bin/jbug/systems?newbug=1&folder=WWW&subject=ECS+-+ECS+Intranet+Login&details=https%3A%2F%2Fsecure.ecs.soton.ac.uk%2Flogin%2F%3Freason%3Dlogin%26uri%3D%252Fnotes%252Felec6016%252Ftjk1314%252Fassignment%252Fcounter.sv%0A%0ADescribe+the+issue+with+the+page...%0A%0A&return_url=https%3A%2F%2Fsecure.ecs.soton.ac.uk%2Flogin%2F%3Freason%3Dlogin%26uri%3D%252Fnotes%252Felec6016%252Ftjk1314%252Fassignment%252Fcounter.sv">Is this page inaccurate, incomplete or out of date? Do you have a suggestion?</a></p>
<p>&copy; University of Southampton</p>
</div> 
</body></html>