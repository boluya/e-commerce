<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>
<html>

<head>
  <title>Administrator Portal</title>
  <link rel="stylesheet" href="css/adminportal.css">
  <script src="https://kit.fontawesome.com/ec7e0e3eb8.js" crossorigin="anonymous"></script>
  <link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-regular-straight/css/uicons-regular-straight.css'>
  <link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-regular-rounded/css/uicons-regular-rounded.css'>
  <link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-regular-straight/css/uicons-regular-straight.css'>
  <link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-regular-straight/css/uicons-regular-straight.css'>
  <link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-regular-straight/css/uicons-regular-straight.css'>
  <link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-regular-straight/css/uicons-regular-straight.css'>
  <link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-regular-straight/css/uicons-regular-straight.css'>

  <style>
    .removeCustLink{
      text-decoration: none;
      color: white;
    }
  </style>


</head>

<body>

<%@ include file="auth.jsp" %>
<%
	String userName = (String) session.getAttribute("authenticatedUser");
%>


  <div class="app-container">
    <div class="sidebar">
      <div class="sidebar-header">
      </div>
      <ul class="sidebar-list">
        <li class="sidebar-list-item active">
          <a href="adminCustomers.jsp ">
            <i class="fi fi-rs-user" style="height: 18px; width: 18px; margin-left: 3px; margin-right: 5px;"></i>
            <span>Customers</span>
          </a>
        </li>
        <li class="sidebar-list-item">
          <a href="adminProducts.jsp">
            <i class="fi fi-rr-bags-shopping" style="height: 18px; width: 18px; margin-left: 3px; margin-right: 5px;"></i>
            <span>Products</span>
          </a>
        </li>
        <li class="sidebar-list-item">
          <a href="adminStats.jsp">
            <i class="fi fi-rs-chart-pie-alt" style="height: 18px; width: 18px; margin-left: 3px; margin-right: 5px;"></i>
            <span>Statistics</span>
          </a>
        </li>
        <li class="sidebar-list-item">
          <a href="adminWarehouseProd.jsp">
            <i class="fi fi-rs-garage-open" style="height: 18px; width: 18px; margin-left: 3px; margin-right: 5px;"></i>
            <span>Warehouse</span>
          </a>
        </li>
        <li class="sidebar-list-item">
          <a href="index.jsp">
            <i class="fi fi-rs-angle-small-left" style="height: 18px; width: 18px; margin-left: 3px; margin-right: 5px;"></i>
            <span>Back to Home</span>
          </a>
        </li>
      </ul>
    </div>
    <div class="app-content">
      <div class="app-content-header">
        <h1 class="app-content-headerText">Customers</h1>
      </div>
      <!-- <div class="app-content-actions">
        <input class="search-bar" placeholder="Search" type="text">
        <button class="searchButton">Search</button>
      </div> -->
      <div class="products-area-wrapper tableView">
        <div class="products-header">
          <div class="product-cell name">Id</div>
          <div class="product-cell category">First Name</div>
          <div class="product-cell stock">Last Name</div>
          <div class="product-cell price"></div>
        </div>
  <%
  String sql = "SELECT customerId, firstName, lastName FROM customer C";

  NumberFormat currFormat = NumberFormat.getCurrencyInstance();

  try 
  {
    getConnection();
    Statement stmt = con.createStatement(); 			
    stmt.execute("USE orders");
    
    PreparedStatement pstmt = con.prepareStatement(sql);
    
    ResultSet rst = pstmt.executeQuery();
    out.println("<div class=\"container\">");
    while (rst.next()) 
    {
      int id = rst.getInt(1);
      String removeLink = "\"removeUser.jsp?id=" + id +"\"";
      String editProduct = "\"adminEditCustomer.jsp?id=" + rst.getInt(1) + "\"";

      out.println("<div class=\"products-row\">");
        out.println("<div class=\"product-cell name\">");
          out.println("<span class=\"cell-label\">Name:</span>");
          out.println(id);
        out.println("</div>");
        out.println("<div class=\"product-cell category\">");
          out.println("<span class=\"cell-label\">Category:</span>");
          out.println(rst.getString(2));
        out.println("</div>");
        out.println("<div class=\"product-cell stock\">");
          out.println("<span class=\"cell-label\">Stock:</span>");
          out.println(rst.getString(3));
        out.println("</div>");
        out.println("<div class=\"product-cell price\">");
          out.println("<span class=\"cell-label\">Price:</span>");
          out.println("<a href=" + editProduct + " style=\"text-decoration: none; color: white;\"><i class=\"fa-regular fa-pen-to-square\"></i></a>");
          out.println("<a class=\"removeCustLink\" href=" + removeLink + " style=\"padding-left: 10px;\"><i class=\"fi fi-rs-trash\"></i></a>");
        out.println("</div>");
      out.println("</div>");
      
    }
      closeConnection();
    } catch (SQLException ex) {
      out.println(ex);
    }
  %>
      </div>
    </div>
  </div>

</body>
</head>