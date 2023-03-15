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
        <li class="sidebar-list-item">
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
        <li class="sidebar-list-item active">
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
        <h1 class="app-content-headerText">Warehouse Inventory</h1>
        <div>
        <button class="app-content-headerButton"><a style="text-decoration: none; color: white;" href="#add-warehouse">Add Warehouse</a></button>
        <button class="app-content-headerButton"><a style="text-decoration: none; color: white;" href="#open-modal">Edit Inventory</a></button>
        </div>

      </div>
      <!-- <div class="app-content-actions">
        <input class="search-bar" placeholder="Search" type="text">
        <button class="searchButton">Search</button>
      </div> -->

      <div class="products-area-wrapper tableView">
        <div class="products-header">
          <div class="product-cell name">Warehouse Id</div>
          <div class="product-cell name">Warehouse Name</div>
          <div class="product-cell name"></div>
        </div>
  <%
  String sql1 = "SELECT warehouseId, warehouseName FROM warehouse";

  try 
  {
    getConnection();
    Statement stmt = con.createStatement(); 			
    stmt.execute("USE orders");
    
    PreparedStatement pstmt = con.prepareStatement(sql1);
    
    ResultSet rst = pstmt.executeQuery();
    out.println("<div class=\"container\">");
    while (rst.next()) 
    {
      String editWarehouse = "\"editWarehouse.jsp?id=" + rst.getString(1) + "\"";
      String removeWarehouse = "\"removeWarehouse.jsp?id=" + rst.getString(1) + "\"";

      out.println("<div class=\"products-row\">");
        out.println("<div class=\"product-cell name\">");
          out.println("<span class=\"cell-label\">Name:</span>");
          out.println(rst.getString(1));
          out.println("</div>");
        out.println("<div class=\"product-cell name\">");
          out.println("<span class=\"cell-label\">Name:</span>");
          out.println(rst.getString(2));
        out.println("</div>");
        out.println("<div class=\"product-cell price\">");
          out.println("<span class=\"cell-label\">Price:</span>");
          out.println("<a style=\"text-decoration: none; color: white;\"><i class=\"fa-regular fa-pen-to-square\"></i></a>");
          out.println("<a style=\"padding-left: 10px; text-decoration: none; color: white;\"><i class=\"fa-regular fa-trash-can\"></i></a>");
        out.println("</div>");
      out.println("</div>");
      
    }
      closeConnection();
    } catch (SQLException ex) {
      out.println(ex);
    }
  %>
      </div>


      <div class="products-area-wrapper tableView">
        <div class="products-header" style="margin-top: 20px;">
          <div class="product-cell name">Warehouse Id</div>
          <div class="product-cell name">Warehouse Name</div>
          <div class="product-cell category">Product</div>
          <div class="product-cell stock">Quantity</div>
          <!-- <div class="product-cell price">Price</div> -->
        </div>
  <%
  String sql = "SELECT W.warehouseId, warehouseName, pN.productName, quantity, price FROM warehouse W JOIN (SELECT productName, warehouseId, P.quantity, P.price FROM product D JOIN productinventory P ON D.productId = P.productId) AS pN ON W.warehouseId = pN.warehouseId";

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
      out.println("<div class=\"products-row\">");
        out.println("<div class=\"product-cell name\">");
          out.println("<span class=\"cell-label\">Name:</span>");
          out.println(rst.getString(1));
          out.println("</div>");
        out.println("<div class=\"product-cell name\">");
          out.println("<span class=\"cell-label\">Name:</span>");
          out.println(rst.getString(2));
        out.println("</div>");
        out.println("<div class=\"product-cell category\">");
          out.println("<span class=\"cell-label\">Category:</span>");
          out.println(rst.getString(3));
        out.println("</div>");
        out.println("<div class=\"product-cell stock\">");
          out.println("<span class=\"cell-label\">Category:</span>");
          out.println(rst.getString(4));
          out.println("</div>");
        //out.println("<div class=\"product-cell price\">");
        //  out.println("<span class=\"cell-label\">Category:</span>");
        //  out.println(rst.getString(5));
        //  out.println("</div>");
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

<div id="open-modal" class="modal-window">
  <div>
    <a href="#" title="Close" class="modal-close">Close</a>
    <form class="form-container" method="GET" action="editInventory.jsp">
      <span>Warehouse Id</span>
      <input type="number" name="warehouseId" value="Warehouse Id">
      <span>Product Id</span>
      <input type="number" name="productId" value="Product Id">
      <span>Product Inventory</span>
      <input type="number" name="stock" value="Product Inventory">
      <span>Price</span>
      <input type="number" name="price" value="Price">
      <input type="submit" value="Submit" style="background-color: #0e1111; color: white;">
    </form>
  </div>
</div>

<div id="add-warehouse" class="modal-window">
  <div>
    <a href="#" title="Close" class="modal-close">Close</a>
    <form class="form-container" method="GET" action="adminAddWarehouse.jsp">
      <span>Warehouse Name</span>
      <input type="text" name="warehouseName">
      <input type="submit" value="Create Warehouse" style="background-color: #0e1111; color: white;">
    </form>
  </div>
</div>

</body>
</head>