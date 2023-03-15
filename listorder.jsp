<%@ page import="java.sql.*" %>
	<%@ page import="java.text.NumberFormat" %>
		<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8" %>
<%@ include file="jdbc.jsp" %>
			<!DOCTYPE html>
			<html>

			<head>
				<title>Order List</title>
				<link rel="stylesheet" href="listorderstyle.css">
				<script src="https://kit.fontawesome.com/ec7e0e3eb8.js" crossorigin="anonymous"></script>
			</head>

			<body>

	<!-- NAVIGATION BAR -->
	<div class="navigation-bar">
		<a href="index.jsp"><i class="fa-solid fa-house"></i>&ensp;Home Page</a>
		<a class="active" href="listorder.jsp"><i class="fa-solid fa-list-ol"></i>&ensp;Orders List</a>
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

				<h1 class="header-order-list">Order List</h1>

				<%
					NumberFormat currFormat = NumberFormat.getCurrencyInstance();

					try
					{

			getConnection();
			Statement stmt = con.createStatement(); 
			stmt.execute("USE orders");
			String sql = "SELECT orderId, ordersummary.customerId, firstName, lastName, totalAmount FROM ordersummary LEFT JOIN customer ON ordersummary.customerId = customer.customerId";
			PreparedStatement pstmt = con.prepareStatement(sql);			
			
			ResultSet rst = pstmt.executeQuery();

						out.println("<table class=\"orders-table\"><tr><th>Order Id</th><th>Customer Id</th><th>Customer Name</th><th>Total Amount</th></tr>");
						while (rst.next())
						{	
							out.println("<tr><td>" + rst.getInt(1) + "</td><td>" + rst.getInt(2) + "</td><td>" + rst.getString(3) + " " + rst.getString(4) + "</td><td>" + currFormat.format(rst.getFloat(5)) + "</td></tr>");
						
							PreparedStatement psmt = con.prepareStatement("SELECT productId, quantity, price FROM orderProduct LEFT JOIN ordersummary ON orderProduct.orderId = ordersummary.orderId WHERE orderproduct.orderId = ?");
							
							psmt.setInt(1, rst.getInt(1));
							ResultSet prst = psmt.executeQuery();
							out.println("<tr align='center'><td colspan='4'>");
							out.println("<table class=\"orders-inner-table\"><tr><th>Product Id</th><th>Quantity</th><th>Price</th></tr>");
							while (prst.next()){
								out.println("<tr><td>" + prst.getInt(1) + "</td><td>" + prst.getInt(2) + "</td><td>" + currFormat.format(prst.getFloat(3)) + "</td>");
							}
							out.println("</table>");
							out.println("</td></tr>");
						}
						out.println("</table>");
					}
					catch (SQLException ex)
					{ out.println(ex);
					}
					%>

			</body>

			</html>