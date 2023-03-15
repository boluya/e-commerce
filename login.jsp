<!DOCTYPE html>
<html>

<head>
        <title>Log-in Portal</title>
				<link rel="stylesheet" href="css/index.css">
				<script src="https://kit.fontawesome.com/ec7e0e3eb8.js" crossorigin="anonymous"></script>
</head>
<body>
	<!-- NAVIGATION BAR -->
	<div class="navigation-bar">
		<a class="active" href="index.jsp"><i class="fa-solid fa-house"></i>&ensp;Home Page</a>
		<a href="listorder.jsp"><i class="fa-solid fa-list-ol"></i>&ensp;Orders List</a>
		<a href="listprod.jsp"><i class="fa-solid fa-store"></i>&ensp;Products List</a>
		<div class="navigation-right-align">
			<%
	String userName = (String) session.getAttribute("authenticatedUser");
	if (userName != null){
		char[] userNames = userName.toCharArray();
    userNames[0] = Character.toUpperCase(userNames[0]);
    userName = String.valueOf(userNames);

			out.println("<div class=\"dropdown\">");
				out.println("<button class=\"dropbtn\"> "+userName);
					out.println("&ensp;<i class=\"fa fa-caret-down\"></i>");
				out.println("</button>");
				out.println("<div class=\"dropdown-content\">");
					out.println("<a href=\"customer.jsp\">View Profile</a>");
					out.println("<a href=\"logout.jsp\">Log out</a>");
				out.println("</div>");
			out.println("</div>");
	}else
		out.println("<a href=\"login.jsp\"><i class=\"fa-solid fa-arrow-right-to-bracket\"></i>&ensp;Sign In</a>");
%>
			<a href="showcart.jsp" class="cart-btn"><i class="fa-solid fa-cart-shopping"></i>&ensp;Cart</a>
		</div>
	</div>
	<div style="margin:0 auto;text-align:center;display:inline">

		<h3>Please Login to System</h3>

		<% 
		// Print prior error login message if present 
		if (session.getAttribute("loginMessage") !=null) 
			out.println("<p>"+session.getAttribute("loginMessage").toString()+"</p>");
			%>

			<br>
			<form name="Form" method=post action="validateLogin.jsp">
				<table style="display:inline">
					<tr>
						<td>
							<div align="right">
								<font face="Arial, Helvetica, sans-serif" size="2">Username:</font>
							</div>
						</td>
						<% if (session.getAttribute("username") !=null){ 
								String username=(String)session.getAttribute("username");
								out.println("<td><input type=\"text\" name=\"username\" value=\"" + username + "\" size=16 maxlength=32></td>");
								session.removeAttribute("username");
							}else{
								out.println("<td><input type=\"text\" name=\"username\" size=16 maxlength=32></td>");
							}

							%>
					</tr>
					<tr>
						<td>
							<div align="right">
								<font face="Arial, Helvetica, sans-serif" size="2">Password:</font>
							</div>
						</td>
						<td><input type="password" name="password" size=16 maxlength="12"></td>
					</tr>
				</table>
				<br />
				<input class="submit" type="submit" name="Submit2" value="Log In">
				<div align="right">
					<button type="submit" formaction="createAccount.jsp">Sign Up</button>
					<button type="submit" formaction="forgotPassword.jsp">Forgot Passowrd?</button>
				</div>

			</form>



	</div>

</body>

</html>