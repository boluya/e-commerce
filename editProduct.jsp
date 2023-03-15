<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Document</title>
  <link rel="stylesheet" href="css/editProduct.css">
</head>

<body>
  <%@ page import="java.text.NumberFormat" %>
	<%@ include file="jdbc.jsp" %>

  <%
  int id = Integer.parseInt(request.getParameter("id"));
  String productName="", productPrice="", productDesc="", categoryId="";
  String sql = "SELECT * FROM product WHERE productId = ?";
  
  try{

      getConnection();
      Statement stmt = con.createStatement(); 			
      stmt.execute("USE orders");
      PreparedStatement pstmt = con.prepareStatement(sql);
      pstmt.setInt(1, id);
      ResultSet rst = pstmt.executeQuery();

      if(!rst.next()){
        return;
      }
      productName = rst.getString(2);
      productPrice = rst.getString(3);
      productDesc = rst.getString(6);
      categoryId = rst.getString(7);

  }catch (SQLException ex) {
      out.println(ex);
  }
  finally{
      closeConnection();
  }
  %>
  <div class="app-content-header">
    <h1 class="app-content-headerText">Edit Product</h1>
  </div>
  <form class="form-container" method="GET" action="editUpdateProduct.jsp">
    <input type="text" name="productId" value="<%out.println(id);%>" readonly>
    <input type="text" name="productName" value="<%out.println(productName);%>">
    <input type="text" name="productPrice" value="<%out.println(productPrice);%>">
    <input type="text" name="productDescription" value="<%out.println(productDesc);%>" />
    <input type="text" name="categoryId" value="<%out.println(categoryId);%>">
    <input type="submit" value="Submit" style="background-color: #0e1111; color: white;" />
  </form>
</body>

</html>