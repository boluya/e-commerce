<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>Bolu's Store - Product Information</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

  <%
  int reviewId = Integer.parseInt(request.getParameter("reviewId"));
  String sql = "SELECT reviewId, reviewRating, reviewDate, customerId, reviewComment FROM review WHERE reviewId = ?";

  try 
  {
    getConnection();
    Statement stmt = con.createStatement(); 			
    stmt.execute("USE orders");
    
    PreparedStatement pstmt = con.prepareStatement(sql);
    pstmt.setInt(1, reviewId);

    
    
    ResultSet rst = pstmt.executeQuery();
    if(rst.next()){
      out.println("<table class=\"table\" border=\"1\">");
      out.println("<tr><th>Comment</th><th>Rating</th></tr>");
      do{
        out.println("<tr><td>" + rst.getString(5) + "</td><td>" + rst.getString(2) + "</td></tr>");
      } while(rst.next());
      out.println("<table/>");
    } else{
      out.println("<h2>NO REVIEWS FOUND</h2>");
    }

  } catch (SQLException ex) {
    out.println(ex);
  } finally{
    closeConnection();
  }
  %>


</body>
</html>

