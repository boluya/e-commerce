<html>
<head>
<title>Update Product</title>
</head>
<body>
<%@ include file="jdbc.jsp" %>

<H1>Add New Warehouse</H1>

<%
int warehouseId = Integer.parseInt(request.getParameter("warehouseId"));
int productId = Integer.parseInt(request.getParameter("productId"));
int stock = Integer.parseInt(request.getParameter("stock"));
int price = Integer.parseInt(request.getParameter("stock"));

String sql = "UPDATE productinventory SET quantity = ?, price = ? WHERE warehouseId = ? AND productId = ?";


try{ 
    getConnection();
    Statement stmt = con.createStatement(); 			
    stmt.execute("USE orders");

    PreparedStatement pstmt = con.prepareStatement(sql);
    pstmt.setInt(1, stock);
    pstmt.setInt(2, price);
    pstmt.setInt(3, warehouseId);
    pstmt.setInt(4, productId);

    pstmt.executeUpdate();
    response.sendRedirect("adminWarehouseProd.jsp");

}catch (SQLException ex) {
    out.println(ex);
}
finally{
    closeConnection();
}
%>
</form>