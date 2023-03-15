<!DOCTYPE html>
<html>

<head>
  <title>Add Product</title>
  <link rel="stylesheet" href="css/adminportal.css">
  <script src="https://kit.fontawesome.com/ec7e0e3eb8.js" crossorigin="anonymous"></script>
</head>

<body>

<%@ page import= "javax.imageio.ImageIO" %>
<%@ page import= "java.awt.image.BufferedImage" %>
<%@ page import="java.io.ByteArrayInputStream" %>
<%@ page import= "java.io.ByteArrayOutputStream" %>
<%@ page import="java.io.File" %>
<%@ include file="jdbc.jsp" %>

  <p>
    <%= request.getParameter("productName")%>
    <%= request.getParameter("productPrice")%>
    <%= request.getParameter("fileurl")%>
    <%= request.getParameter("productDescription")%>
  </p>
  <%out.println("<img src=\"" + request.getParameter("fileurl") + "\"/>");%>

<%
String productName = request.getParameter("productName");
Double productPrice = Double.valueOf(request.getParameter("productPrice"));
String fileUrl = request.getParameter("url");
String filename = request.getParameter("file");
String fileDescription = request.getParameter("filedescription");



String sql = "INSERT INTO product (productName, productPrice, productImageURL, productImage, productDesc, categoryId) VALUES(?, ?, ?, ?, ?, ?)";

//NumberFormat currFormat = NumberFormat.getCurrencyInstance();

try 
{
	getConnection();
	Statement stmt = con.createStatement(); 			
	stmt.execute("USE orders");
	
	PreparedStatement pstmt = con.prepareStatement(sql);
	pstmt.setString(1, productName);
  pstmt.setDouble(2, productPrice);
	pstmt.setString(3, fileUrl);
	pstmt.setNull(4, java.sql.Types.BINARY);
	pstmt.setString(5, fileDescription);
	pstmt.setInt(6, 1);
	pstmt.executeUpdate();
	pstmt.close();
} 
catch (SQLException ex) {
	out.println(ex);
}
finally
{
	closeConnection();
	response.sendRedirect("adminportal.jsp");
}
%>



</body>

</html>