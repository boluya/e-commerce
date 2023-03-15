<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Document</title>
</head>
<body>
  <%@ page import="java.text.NumberFormat" %>
	<%@ include file="jdbc.jsp" %>

  <%
  int id = Integer.parseInt(request.getParameter("productId"));
  String productName = request.getParameter("productName");
  String productPrice = request.getParameter("productPrice");
  String productDescription = request.getParameter("productDescription");
  String categoryId = request.getParameter("categoryId");

  String sql = "UPDATE product SET productName = ?, productPrice = ?, productDesc = ?, categoryId = ? WHERE productId = ?";

  try{ 
      getConnection();
      Statement stmt = con.createStatement(); 			
      stmt.execute("USE orders");
      PreparedStatement pstmt = con.prepareStatement(sql);
      pstmt.setString(1, productName);
      pstmt.setString(2, productPrice);
      pstmt.setString(3, productDescription);
      pstmt.setString(4, categoryId);
      pstmt.setInt(5, id);

      pstmt.executeUpdate();
  }catch (SQLException ex) {
      out.println(ex);
  }
  finally{
      closeConnection();
      response.sendRedirect("adminProducts.jsp");
  }
  %>
</body>
</html>