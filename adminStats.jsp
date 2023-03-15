<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="java.util.ArrayList" %>
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
        <li class="sidebar-list-item active">
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
        <h1 class="app-content-headerText">Statistics</h1>
      </div>
      <!-- <div class="app-content-actions">
        <input class="search-bar" placeholder="Search" type="text">
        <button class="searchButton">Search</button>
      </div> -->
      <div class="products-area-wrapper tableView">
        <div class="products-header">
          <div class="product-cell name">Order Date</div>
          <div class="product-cell category">Total Sales</div>
          <!-- <div class="product-cell stock">Last Name</div> -->
          <!-- <div class="product-cell price"></div> -->
        </div>
  <%
  String sql = "select year(orderDate), month(orderDate), day(orderDate), SUM(totalAmount) FROM OrderSummary GROUP BY year(orderDate), month(orderDate), day(orderDate)";

  NumberFormat currFormat = NumberFormat.getCurrencyInstance();
  ArrayList<String> labels = new ArrayList<String>();
  ArrayList<Double> dataValues = new ArrayList<Double>();
  try 
  {
    getConnection();
    Statement stmt = con.createStatement(); 			
    stmt.execute("USE orders");
    
    ResultSet rst = con.createStatement().executeQuery(sql);

    out.println("<div class=\"container\">");
    while (rst.next()) 
    {
      labels.add("\"" + rst.getString(1)+"-"+rst.getString(2)+"-"+rst.getString(3) + "\"");
      dataValues.add(rst.getDouble(4));
      int id = rst.getInt(1);
      String removeLink = "\"removeUser.jsp?id=" + id +"\"";
      out.println("<div class=\"products-row\">");
        out.println("<div class=\"product-cell name\">");
          out.println("<span class=\"cell-label\">Name:</span>");
          out.println(rst.getString(1)+"-"+rst.getString(2)+"-"+rst.getString(3));
        out.println("</div>");
        out.println("<div class=\"product-cell category\">");
          out.println("<span class=\"cell-label\">Category:</span>");
          out.println(currFormat.format(rst.getDouble(4)));
        out.println("</div>");
      out.println("</div>");
      
    }
  } catch (SQLException ex) {
      out.println(ex);
  } finally {
    closeConnection();
  }
  %>
      </div>
      <div class="graph-container">
        <canvas id="myChart"></canvas>
      </div>
    </div>
  </div>


<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<script>
  const ctx = document.getElementById('myChart');
  const labels = <%out.println(Arrays.toString(labels.toArray()));%>;
  const data = {
    labels: labels,
    datasets: [{
      label: 'Total Sales',
      data: <%out.println(Arrays.toString(dataValues.toArray()));%>,
      backgroundColor: 'rgba(201, 203, 207, 0.2)',
      borderColor: 'rgb(201, 203, 207)',
      borderWidth: 1
}]
};

  const config = {
    type: 'bar',
    data: data,
    options: {
      scales: {
        y: {
          beginAtZero: true
        }
      }
    },
  };

  new Chart(ctx, config);
</script>


</body>
</head>