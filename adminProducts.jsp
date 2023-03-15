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
</head>

<body>
  <div class="app-container">
    <div class="sidebar">
      <div class="sidebar-header">
      </div>
      <ul class="sidebar-list">
        <li class="sidebar-list-item">
          <a href="adminCustomers.jsp">
            <i class="fi fi-rs-user" style="height: 18px; width: 18px; margin-left: 3px; margin-right: 5px;"></i>
            <span>Customers</span>
          </a>
        </li>
        <li class="sidebar-list-item active">
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
        <h1 class="app-content-headerText">Products</h1>
        <button class="app-content-headerButton"><a style="text-decoration: none; color: white;" href="#open-modal">Add Product</a></button>
      </div>
      <!-- <div class="app-content-actions">
        <input class="search-bar" placeholder="Search" type="text">
        <button class="searchButton">Search</button>
      </div> -->
      <div class="products-area-wrapper tableView">
        <div class="products-header">
          <div class="product-cell name">Product</div>
          <div class="product-cell category">Category</div>
          <div class="product-cell stock">Stock</div>
          <div class="product-cell price">Price</div>
          <div class="product-cell price"></div>
        </div>
  <%
  String sql = "SELECT productId, productName, productPrice, categoryName, productImageURL, productImage FROM Product P JOIN Category C ON P.categoryId = C.categoryId";

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
      String itemCategory = rst.getString(4);
      String removeProduct = "\"removeProduct.jsp?id=" + rst.getInt(1) + "\"";
      String editProduct = "\"editProduct.jsp?id=" + rst.getInt(1) + "\"";

      
      out.println("<div class=\"products-row\">");
        out.println("<div class=\"product-cell name\">");
          out.println("<span class=\"cell-label\">Name:</span>");
          out.println(rst.getString(2));
        out.println("</div>");
        out.println("<div class=\"product-cell category\">");
          out.println("<span class=\"cell-label\">Category:</span>");
          out.println("<span class=\"status active\">" + itemCategory + "</span>");
        out.println("</div>");
        out.println("<div class=\"product-cell stock\">");
          out.println("<span class=\"cell-label\">Stock:</span>");
          out.println("0");
        out.println("</div>");
        out.println("<div class=\"product-cell price\">");
          out.println("<span class=\"cell-label\">Price:</span>");
          out.println(currFormat.format(rst.getDouble(3)));
        out.println("</div>");
        out.println("<div class=\"product-cell price\">");
          out.println("<span class=\"cell-label\">Price:</span>");
          out.println("<a href=" + editProduct + " style=\"text-decoration: none; color: white;\"><i class=\"fa-regular fa-pen-to-square\"></i></a>");
          out.println("<a href=" + removeProduct + " style=\"padding-left: 10px; text-decoration: none; color: white;\"><i class=\"fa-regular fa-trash-can\"></i></a>");
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

<div id="open-modal" class="modal-window">
  <div>
    <a href="#" title="Close" class="modal-close">Close</a>
  <form class="form-container" method="GET" action="addProduct.jsp">
    <input type="text" name="productName" value="Product Name">
    <input type="text" name="productPrice" value="Product Price">
    <input type="url" name="url" value="http://example.com/">
    <input type="file" name="file" accept="image/gif, image/jpeg, image/png" value="Image">
    <input type="text" name="productDescription" value="Product Description" />
    <input type="submit" value="Submit" />
  </form>
  </div>
</div>

</body>
</head>