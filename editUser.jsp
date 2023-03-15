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
  String firstName = request.getParameter("firstName");
  String lastName = request.getParameter("lastName");
  String email = request.getParameter("email");
  String phone = request.getParameter("phone");
  String address = request.getParameter("address");
  String city = request.getParameter("city");
  String state = request.getParameter("state");
  String postalCode = request.getParameter("postalCode");
  String country = request.getParameter("country");
  String userid = request.getParameter("userid");
  String password = request.getParameter("password");


  String sql = "UPDATE customer SET firstName = ?, lastName = ?, email = ?, phonenum = ?, address = ?, city = ?, state = ?, postalCode = ?, country = ?, userid = ?, password = ? WHERE customerId = ?";

  try{ 
      getConnection();
      Statement stmt = con.createStatement(); 			
      stmt.execute("USE orders");
      PreparedStatement pstmt = con.prepareStatement(sql);
      pstmt.setString(1, firstName);
      pstmt.setString(2, lastName);
      pstmt.setString(3, email);
      pstmt.setString(4, phone);
      pstmt.setString(5, address);
      pstmt.setString(6, city);
      pstmt.setString(7, state);
      pstmt.setString(8, postalCode);
      pstmt.setString(9, country);
      pstmt.setString(10, userid);
      pstmt.setString(11, password);
      pstmt.setInt(12, id);

      pstmt.executeUpdate();
  }catch (SQLException ex) {
      out.println(ex);
  }
  finally{
      closeConnection();
      response.sendRedirect("customer.jsp");
  }
  %>
</body>

</html>