<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Document</title>
  <link rel="stylesheet" href="css/editProduct.css">
</head>

<body>
	<%

	// Print Customer information
  int id = Integer.parseInt(request.getParameter("id"));
	String sql = "select customerId, firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password FROM Customer WHERE customerId = ?";

	NumberFormat currFormat = NumberFormat.getCurrencyInstance();
	String firstName = "", lastName = "", email = "", phonenum = "", address = "", city = "", state = "", postalCode = "", country = "", userid = "", password = "";

	try 
	{	
		
		getConnection();
		Statement stmt = con.createStatement(); 
		stmt.execute("USE orders");

		PreparedStatement pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, id);	
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
  <div class="app-content-header">
    <h1 class="app-content-headerText">Edit Product</h1>
  </div>
			<form class="form-container" method="GET" action="editCustomer.jsp">
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
</body>

</html>