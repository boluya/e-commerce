<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>
<%
int id =  Integer.parseInt((String)session.getAttribute("id"));
int productId = Integer.parseInt(request.getParameter("productId"));
int rating = Integer.parseInt(request.getParameter("rating"));
String comment = request.getParameter("comment");
  try 
  {
  getConnection();
  Statement stmt = con.createStatement();             
  stmt.execute("USE orders");

   String query = "INSERT INTO review(reviewRating, reviewDate, customerId, productId, reviewComment) values(?, GETDATE(), ?, ?, ?)";
   PreparedStatement pstmt2 = con.prepareStatement(query);

   pstmt2.setInt(1, rating);
   pstmt2.setInt(2, id);
   pstmt2.setInt(3, productId);
   pstmt2.setString(4, comment);

   int x = pstmt2.executeUpdate();

} catch (SQLException ex) {
    out.println(ex);
  } finally{
    closeConnection();
    response.sendRedirect("product.jsp?id=" + productId);
  }
  %>