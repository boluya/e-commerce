<!DOCTYPE html>
<html>
<head>
<title>Customer Page</title>
				<link rel="stylesheet" href="css/customer.css">
				<script src="https://kit.fontawesome.com/ec7e0e3eb8.js" crossorigin="anonymous"></script>
</head>
<body>

		<!-- NAVIGATION BAR -->
	<div class="navigation-bar">
		<a href="index.jsp"><i class="fa-solid fa-house"></i>&ensp;Home Page</a>
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



	<%@ include file="auth.jsp"%>
	<%@ page import="java.text.NumberFormat" %>
	<%@ include file="jdbc.jsp" %>

	<%

	// Print Customer information
	String sql = "select customerId, firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password FROM Customer WHERE userid = ?";

	NumberFormat currFormat = NumberFormat.getCurrencyInstance();
	int id = 0;
	String firstName = "", lastName = "", email = "", phonenum = "", address = "", city = "", state = "", postalCode = "", country = "", userid = "", password = "";

	try 
	{	
		
		getConnection();
		Statement stmt = con.createStatement(); 
		stmt.execute("USE orders");

		PreparedStatement pstmt = con.prepareStatement(sql);
		pstmt.setString(1, userName);	
		ResultSet rst = pstmt.executeQuery();
		
		if (rst.next())
		{
			id = Integer.parseInt(rst.getString(1));
			firstName = rst.getString(2);
			lastName = rst.getString(3);
			email = rst.getString(4);
			phonenum = rst.getString(5);
			address = rst.getString(6);
			city = rst.getString(7);
			state = rst.getString(8);
			postalCode = rst.getString(9);
			country = rst.getString(10);
			userid = rst.getString(11);
			password = rst.getString(12);

			out.println("<div class=\"app-content-header\">");
				out.println("<h1 class=\"app-content-headerText\">Hello " + rst.getString(2) + "</h1>");
				out.println("<p class=\"app-content-headerPara\">This is your profile page. Here you can see your account details and make any necessary changes to keep your account up-to-date.</p>");
			out.println("</div>");

			out.println("<div class=\"app-content\">");
				out.println("<div style=\"width: 50%;\">");
					out.println("<div class=\"app-content-header-row\">");
						out.println("<h1 class=\"app-content-headerText-wht\" style=\"font-size: 24px !important;\">Your Details</h1>");
						out.println("<button class=\"app-content-headerButton\"><a style=\"text-decoration: none; color: white;\" href=\"#open-modal\">Edit Account</a></button>");
					out.println("</div>");
					out.println("<table class=\"dataTable\">");
						out.println("<tr><th class=\"dataTable-header\">Id</th><td style=\"text-align: left; padding: 5px;\">"+rst.getString(1)+"</td></tr>");	
						out.println("<tr><th class=\"dataTable-header\">First Name</th><td style=\"text-align: left; padding: 5px;\">"+rst.getString(2)+"</td></tr>");
						out.println("<tr><th class=\"dataTable-header\">Last Name</th><td style=\"text-align: left; padding: 5px;\">"+rst.getString(3)+"</td></tr>");
						out.println("<tr><th class=\"dataTable-header\">Email</th><td style=\"text-align: left; padding: 5px;\">"+rst.getString(4)+"</td></tr>");
						out.println("<tr><th class=\"dataTable-header\">Phone</th><td style=\"text-align: left; padding: 5px;\">"+rst.getString(5)+"</td></tr>");
						out.println("<tr><th class=\"dataTable-header\">Address</th><td style=\"text-align: left; padding: 5px;\">"+rst.getString(6)+"</td></tr>");
						out.println("<tr><th class=\"dataTable-header\">City</th><td style=\"text-align: left; padding: 5px;\">"+rst.getString(7)+"</td></tr>");
						out.println("<tr><th class=\"dataTable-header\">State</th><td style=\"text-align: left; padding: 5px;\">"+rst.getString(8)+"</td></tr>");
						out.println("<tr><th class=\"dataTable-header\">Postal Code</th><td style=\"text-align: left; padding: 5px;\">"+rst.getString(9)+"</td></tr>");
						out.println("<tr><th class=\"dataTable-header\">Country</th><td style=\"text-align: left; padding: 5px;\">"+rst.getString(10)+"</td></tr>");
						out.println("<tr><th class=\"dataTable-header\">User id</th><td style=\"text-align: left; padding: 5px;\">"+rst.getString(11)+"</td></tr>");	
						out.println("<tr><th class=\"dataTable-header\">Password</th><td style=\"text-align: left; padding: 5px;\">"+rst.getString(12)+"</td></tr>");		
					out.println("</table>");
				out.println("</div>");
		}
	}
	catch (SQLException ex) 
	{ 	out.println(ex); 
	}
	finally
	{	
		closeConnection();	
	}
	%>
			<div style="width: 50%;">
				<h1 class="app-content-headerText-wht" style="font-size: 24px !important;">Your Orders</h1>
				<div>
<%
sql = "SELECT orderId, O.CustomerId, totalAmount, firstName+' '+lastName, orderDate FROM OrderSummary O, Customer C WHERE " + "O.customerId = ? AND C.customerId = ?";

try  
{	
		getConnection();
		Statement stmt = con.createStatement(); 
		stmt.execute("USE orders");

		PreparedStatement pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, id);	
		pstmt.setInt(2, id);	
		ResultSet rst = pstmt.executeQuery();	
	
	// Use a PreparedStatement as will execute many times
	sql = "SELECT productId, quantity, price FROM OrderProduct WHERE orderId=?";
	pstmt = con.prepareStatement(sql);
	while (rst.next())
	{	
		out.println("<table class=\"orderTable\">");
		int orderId = rst.getInt(1);
		out.println("<tr><th class=\"orderTable-header\">Order Id</th><th class=\"orderTable-header\">Order Date</th></tr>");
		out.print("<tr><td style=\"text-align: left; padding: 5px;\">"+orderId+"</td>");
		out.print("<td style=\"text-align: left; padding: 5px;\">"+rst.getString(5)+"</td>");
		out.println("</tr>");

		// Retrieve all the items for an order
		pstmt.setInt(1, orderId);				
		ResultSet rst2 = pstmt.executeQuery();
		
		out.println("<tr><table class=\"orderTable-contents\">");
		out.println("<tr><th>Product Id</th> <th>Quantity</th> <th>Price</th></tr>");
		while (rst2.next())
		{
			out.print("<tr><td style=\"text-align: left; padding: 5px;\">"+rst2.getInt(1)+"</td>");
			out.print("<td style=\"text-align: left; padding: 5px;\">"+rst2.getInt(2)+"</td>");
			out.println("<td style=\"text-align: left; padding: 5px;\">"+currFormat.format(rst2.getDouble(3))+"</td></tr>");
		}
		out.println("</table></tr>");
	}
	out.println("</table>");
}
catch (SQLException ex) 
{ 	out.println(ex); 
}
finally
{
	closeConnection();
}
%>
			</div>
		</div>
	</div>


	<div id="open-modal" class="modal-window">
		<div>
			<a href="#" title="Close" class="modal-close">Close</a>
			<form class="form-container" method="GET" action="editUser.jsp">
				<input type="text" name="id" readonly value="<%out.println(id);%>">
				<input type="text" name="firstName" value="<%out.println(firstName);%>">
				<input type="text" name="lastName" value="<%out.println(lastName);%>">
				<input type="text" name="email" value="<%out.println(email);%>">
				<input type="text" name="phone" value="<%out.println(phonenum);%>">
				<input type="text" name="address" value="<%out.println(address);%>">
				<input type="text" name="city" value="<%out.println(city);%>">
				<input type="text" name="state" value="<%out.println(state);%>">
				<input type="text" name="postalCode" value="<%out.println(postalCode);%>">
				<input type="text" name="country" value="<%out.println(country);%>">
				<input type="text" name="userid" value="<%out.println(userid);%>">
				<input type="text" name="password" value="<%out.println(password);%>">
				<input type="submit" value="Submit" />
			</form>
		</div>
	</div>

</body>
</html>

