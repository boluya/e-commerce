<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<html>
<head>
				<title>Products List</title>
				<link rel="stylesheet" href="css/listprod.css">
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
			<a href="showcart.jsp"><i class="fa-solid fa-cart-shopping"></i>&ensp;Cart</a>
		</div>
	</div>

<h1 class="header-search-products">Search for the ships you want to buy:</h1>
<div class="search-container">
<form method="get" action="listprod.jsp">
  <p align="left">
  <select class="select-element" size="1" name="categoryName">
  <option>All</option>

<%
/*
// Could create category list dynamically - more adaptable, but a little more costly
try               
{
	getConnection();
 	ResultSet rst = executeQuery("SELECT DISTINCT categoryName FROM Product");
        while (rst.next()) 
		out.println("<option>"+rst.getString(1)+"</option>");
}
catch (SQLException ex)
{       out.println(ex);
}
*/
%>

		<option>23th Century</option>
		<option>24th Century</option>
		<option>25th Century</option>
		<option>31st Century</option>  
		</select>
		<input class="search-box" type="text" name="productName" size="50">
		<input class="submit-btn" type="submit" value="Submit">
		<input class="reset-btn" type="reset" value="Reset"> (Leave blank for all products)
	</form>
</div>

<%
// Colors for different item categories
HashMap<String,String> colors = new HashMap<String,String>();		// This may be done dynamically as well, a little tricky...
colors.put("Beverages", "#b3ffb3");
colors.put("Condiments", "#f26ca7");
colors.put("Confections", "#17b890");
colors.put("Dairy Products", "#5e4ae3");
colors.put("Grains/Cereals", "#06bee1");
colors.put("Meat/Poultry", "#21295c");
colors.put("Produce", "#adff2f");
colors.put("Seafood", "#eff4ff");
%>

<%
// Get product name to search for
String name = request.getParameter("productName");
String category = request.getParameter("categoryName");

boolean hasNameParam = name != null && !name.equals("");
boolean hasCategoryParam = category != null && !category.equals("") && !category.equals("All");
String filter = "", sql = "";

if (hasNameParam && hasCategoryParam)
{
	filter = "<h3 class=\"header-search-products\">Products containing '"+name+"' in category: '"+category+"'</h3>";
	name = '%'+name+'%';
	sql = "SELECT productId, productName, productPrice, categoryName, productImageURL, productImage FROM Product P JOIN Category C ON P.categoryId = C.categoryId WHERE productName LIKE ? AND categoryName = ?";
}
else if (hasNameParam)
{
	filter = "<h3 class=\"header-search-products\">Products containing '"+name+"'</h3>";
	name = '%'+name+'%';
	sql = "SELECT productId, productName, productPrice, categoryName, productImageURL, productImage FROM Product P JOIN Category C ON P.categoryId = C.categoryId WHERE productName LIKE ?";
}
else if (hasCategoryParam)
{
	filter = "<h3 class=\"header-search-products\">Products in category: '"+category+"'</h3>";
	sql = "SELECT productId, productName, productPrice, categoryName, productImageURL, productImage FROM Product P JOIN Category C ON P.categoryId = C.categoryId WHERE categoryName = ?";
}
else
{
	filter = "<h3 class=\"header-search-products\">All Products</h3>";
	sql = "SELECT productId, productName, productPrice, categoryName, productImageURL, productImage FROM Product P JOIN Category C ON P.categoryId = C.categoryId";
}

out.println(filter);

NumberFormat currFormat = NumberFormat.getCurrencyInstance();

try 
{
	getConnection();
	Statement stmt = con.createStatement(); 			
	stmt.execute("USE orders");
	
	PreparedStatement pstmt = con.prepareStatement(sql);
	if (hasNameParam)
	{
		pstmt.setString(1, name);	
		if (hasCategoryParam)
		{
			pstmt.setString(2, category);
		}
	}
	else if (hasCategoryParam)
	{
		pstmt.setString(1, category);
	}
	
	ResultSet rst = pstmt.executeQuery();
	out.println("<div class=\"container\">");
	while (rst.next()) 
	{
		int id = rst.getInt(1);
		String link = "\"addcart.jsp?id=" + id + "&name=" + rst.getString(2) + "&price=" + rst.getDouble(3) + "\"";

		String itemCategory = rst.getString(4);
		String color = (String) colors.get(itemCategory);
		if (color == null)
			color = "#FFFFFF";

		//out.println("<div class=\"card\" >");
		//	out.println("<div class=\"card-body\">");
		//		out.println("<button class=\"pill-" + itemCategory + "\">" + itemCategory + "</button>");
		//		out.println("<h4>" + rst.getString(2) + "</h4>");
		//		out.println("<p>" + currFormat.format(rst.getDouble(3)) + "</p>");
		//		out.println("<p><a href=" + link + "><i class=\"fa-solid fa-cart-plus\"></i></a></p>");
		//	out.println("</div>");
		//out.println("</div>");
		out.println("<a href=\"product.jsp?id=" + rst.getString(1) + "\" style=\"text-decoration: none;\">");
		out.println("<div class=\"card\">");
			out.println("<img src=\"" + rst.getString(5) + "\" style=\"width:100%\">");
			out.println("<div class=\"card-container\">");
				out.println("<h3 style=\"font-weight: 400;\"><b>" + rst.getString(2) + "</b></h3>");
				//out.println("<p>Federation Starship | Heavy cruiser</p>");
				out.println("<p>Designed " + rst.getString(4) + "</p>");
			out.println("</div>");
		out.println("</div>");
		out.println("</a>");
	}
	out.println("</div>");
	closeConnection();
} catch (SQLException ex) {
	out.println(ex);
}
%>





</body>
</html>

