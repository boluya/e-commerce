<!DOCTYPE html>
<html>
<head>
<title>Administrator Page</title>
	<link rel="stylesheet" href="css/adminportal.css">
	<script src="https://kit.fontawesome.com/ec7e0e3eb8.js" crossorigin="anonymous"></script>
</head>
<body>

<%@ include file="auth.jsp"%>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>

<%
	String userName = (String) session.getAttribute("authenticatedUser");
%>

<%

// Print out total order amount by day
String sql = "select year(orderDate), month(orderDate), day(orderDate), SUM(totalAmount) FROM OrderSummary GROUP BY year(orderDate), month(orderDate), day(orderDate)";

NumberFormat currFormat = NumberFormat.getCurrencyInstance();

try 
{	
	out.println("<h3>Administrator Sales Report by Day</h3>");
	
	getConnection();
	Statement stmt = con.createStatement(); 
	stmt.execute("USE orders");

	ResultSet rst = con.createStatement().executeQuery(sql);		
	out.println("<table class=\"table\" border=\"1\">");
	out.println("<tr><th>Order Date</th><th>Total Order Amount</th></tr>");	

	while (rst.next())
	{
		out.println("<tr><td>"+rst.getString(1)+"-"+rst.getString(2)+"-"+rst.getString(3)+"</td><td>"+currFormat.format(rst.getDouble(4))+"</td></tr>");
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

String sqlCustomer = "SELECT customerId, firstName, lastName FROM customer";

try 
{	
	out.println("<h3>CUSTOMER LIST</h3>");
	
	getConnection();
	Statement stmt = con.createStatement(); 
	stmt.execute("USE orders");

	ResultSet rst = con.createStatement().executeQuery(sqlCustomer);		
	out.println("<table class=\"table\" border=\"1\">");
	out.println("<tr><th>ID</th><th>LAST NAME</th><th>FIRST NAME</th></tr>");	

	while (rst.next())
	{
		out.println("<tr><td>" + rst.getString(1) + "</td><td>" + rst.getString(3) + "</td><td>" + rst.getString(2) + "</td></tr>");
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

<form class="form-container" method="GET" action="addProduct.jsp">
	<input type="text" name="productName" value="Product Name">
	<input type="text" name="productPrice" value="Product Price">
	<input type="url" name="url" value="http://example.com/">
	<input type="file" name="file" accept="image/gif, image/jpeg, image/png" value="Image">
	<input type="text" name="productDescription" value="Product Description"/>
	<input type="submit" value="Submit"/>
</form>
<img src="img\earth.png">
</body>
</html>

