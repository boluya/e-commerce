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
  int id = Integer.parseInt(request.getParameter("id"));

  String sql = "DELETE FROM productinventory WHERE productId = ?";
  String sql3 = "DELETE FROM orderproduct WHERE productId = ?";
  String sql2 = "DELETE FROM product WHERE productId = ?";
  

  try{

      getConnection();
      Statement stmt = con.createStatement(); 			
      stmt.execute("USE orders");
      PreparedStatement pstmt = con.prepareStatement(sql);
      pstmt.setInt(1, id);
      pstmt.executeUpdate();
      
      pstmt = con.prepareStatement(sql3);
      pstmt.setInt(1, id);
      pstmt.executeUpdate();
      
      pstmt = con.prepareStatement(sql2);
      pstmt.setInt(1, id);
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