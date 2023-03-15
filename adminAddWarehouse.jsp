<%@ include file="jdbc.jsp" %>
<html>
<head>
<title>Update Product</title>
</head>
<body>

<%
String warehouseName = request.getParameter("warehouseName");
String query = "INSERT warehouse(warehouseName) VALUES (?)";

try 
{
	getConnection();
	Statement stmt = con.createStatement(); 			
	stmt.execute("USE orders");
	
  PreparedStatement pstmt = con.prepareStatement(query);
  pstmt.setString(1, warehouseName);

	pstmt.executeUpdate();
	pstmt.close();
} 
catch (SQLException ex) {
	out.println(ex);
}
finally
{
	closeConnection();
	response.sendRedirect("adminWarehouseProd.jsp");
}
%>



</form>