<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<html>
<head>
				<title>Products Page</title>
				<link rel="stylesheet" href="css/productsPage.css">
				<script src="https://kit.fontawesome.com/ec7e0e3eb8.js" crossorigin="anonymous"></script>
</head>
<body>

	<!-- NAVIGATION BAR -->
	<div class="navigation-bar">
		<a href="index.jsp"><i class="fa-solid fa-house"></i>&ensp;Home Page</a>
		<a href="listorder.jsp"><i class="fa-solid fa-list-ol"></i>&ensp;Orders List</a>
		<a class="active" href="listprod.jsp"><i class="fa-solid fa-store"></i>&ensp;Products List</a>
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

<%
// Get product name to search for
String productId = request.getParameter("id");
String sql = "SELECT productId, productName, productPrice, productImageURL, productImage, productDesc FROM Product P  WHERE productId = ?";
NumberFormat currFormat = NumberFormat.getCurrencyInstance();
int prodId = 0;
try 
{
	getConnection();
	Statement stmt = con.createStatement(); 			
	stmt.execute("USE orders");
	
	PreparedStatement pstmt = con.prepareStatement(sql);
	pstmt.setInt(1, Integer.parseInt(productId));			
	
	ResultSet rst = pstmt.executeQuery();
			
	if (!rst.next())
	{
		out.println("Invalid product");
	}
	else
	{		
		out.println("<h2>"+rst.getString(2)+"</h2>");
		
		prodId = rst.getInt(1);
		String prodDesc = rst.getString(6);
		out.println("<table><tr>");
		out.println("<th>Description: </th><td>" + prodDesc + "</td></tr>"				
				+ "<tr><th>Price</th><td>" + currFormat.format(rst.getDouble(3)) + "</td></tr>");
		
		//  Retrieve any image with a URL
		String imageLoc = rst.getString(4);
		if (imageLoc != null)
			out.println("<img src=\""+imageLoc+"\">");
		
		// Retrieve any image stored directly in database
		String imageBinary = rst.getString(5);
		if (imageBinary != null)
			out.println("<img src=\"displayImage.jsp?id="+prodId+"\">");	
		out.println("</table>");
		
		out.println("<h3><a href=\"addcart.jsp?id="+prodId+ "&name=" + rst.getString(2)
								+ "&price=" + rst.getDouble(3)+"\">Add to Cart</a></h3>");		
		
		out.println("<h3><a href=\"listprod.jsp\">Continue Shopping</a>");
	}
} 
catch (SQLException ex) {
	out.println(ex);
}
finally
{
	closeConnection();
}
%>
<%
  
  String sql2 = "SELECT reviewId, reviewRating, reviewDate, firstName, lastName, reviewComment FROM review R JOIN customer C ON R.customerId = C.customerId WHERE productId = ?";

  try 
  {
    getConnection();
    Statement stmt = con.createStatement();             
    stmt.execute("USE orders");
    
    PreparedStatement pstmt1 = con.prepareStatement(sql2);
    pstmt1.setInt(1, prodId);

    
    
    ResultSet rst1 = pstmt1.executeQuery();
    if(rst1.next()){
      out.println("<table class=\"table\" border=\"1\">");
      out.println("<tr><th>Reviwer</th><th>Rating</th><th>Date</th><th>Comment</th></tr>");
      do{
        out.println("<tr><td>" + rst1.getString(4) + " " + rst1.getString(5) + "</td><td>" + rst1.getString(2) + "</td><td>" + rst1.getString(3) + "</td><td>" + rst1.getString(6) +"</td></tr>");
      } while(rst1.next());
      out.println("</table>");
    } else{
      out.println("<h2>NO REVIEWS FOUND</h2>");
    }

  } catch (SQLException ex) {
    out.println(ex);
  } finally{
    closeConnection();
  }
  %>

	<%
	int custid =  Integer.parseInt((String)session.getAttribute("id"));
	String sql1 = "SELECT * FROM review WHERE customerId = ? AND productId = ?";
	try 
  {
    getConnection();
    Statement stmt = con.createStatement();             
    stmt.execute("USE orders");
    
    PreparedStatement pstmt2 = con.prepareStatement(sql1);
    pstmt2.setInt(1, custid);
		pstmt2.setInt(2, prodId);
    ResultSet rst2 = pstmt2.executeQuery();
    if(rst2.next()){
			out.println("<div class=\"app-content-header\">");
			out.println("<h1 class=\"app-content-headerText\">You have already reviewed this item!</h1>");
			return;
    }
			out.println("<div style=\"width: 40%; padding: 20px;\">");
			out.println("<div class=\"app-content-header\">");
			out.println("<h1 class=\"app-content-headerText\">Enter a Review:</h1>");
			out.println("</div>");
			out.println("<form class=\"form-container\" method=\"GET\" action=\"review.jsp\">");
			out.println("<span style=\"text-align: left !important;\">Product Id</span>");
			out.println("<input type=\"text\" name=\"productId\" value=\"" + prodId + "\" readonly>");
			out.println("<span style=\"text-align: left !important;\">Rating (1 - 5):</span>");
			out.println("<input type=\"number\" name=\"rating\" min=\"1\" max=\"5\">");
			out.println("<span style=\"text-align: left !important;\">Comment:</span>");
			out.println("<textarea name=\"comment\" rows=\"5\" cols=\"50\"></textarea>");
			out.println("<input type=\"submit\" value=\"Submit\" style=\"background-color: #0e1111; color: white;\"/>");
			out.println("</form>");
			out.println("</div>");

  } catch (SQLException ex) {
    out.println(ex);
  } finally{
    closeConnection();
  }
	%>

		<!-- <div style="width: 40%; padding: 20px;">
			<div class="app-content-header">
				<h1 class="app-content-headerText">Enter a Review:</h1>
			</div>
			<form class="form-container" method="GET" action="review.jsp">
				<span style="text-align: left !important;">Product Id</span>
				<input type="text" name="productId" value="<%out.println(prodId);%>" readonly>
				<span style="text-align: left !important;">Rating (1 - 5):</span>
				<input type="number" name="rating" min="1" max="5">
				<span style="text-align: left !important;">Comment:</span>
				<textarea name="comment" rows="5" cols="50"></textarea>
				<input type="submit" value="Submit" style="background-color: #0e1111; color: white;" />
			</form>
		</div> -->

</body>
</html>