<!DOCTYPE html>
<html>

<head>
  <title>Finding Password Page</title>
</head>

<body>
  <H1 align="center">
    <font color="#3399FF"><a href="index.jsp">HOME</a></font>
  </H1>
  <h3>Finding Password</h3>
  <br>
  <% session=request.getSession(true); %>

    <table style="display:inline">

      <tr>
        <td>
          <front>Reset Password by Email</front>
        </td>
      </tr>

      <tr>
        <form name="Form" method=post action="validateReset.jsp">
          <td>
            <div align="right">
              <font face="Arial, Helvetica, sans-serif" size="2">Enter Email:</font>
            </div>
          </td>
          <td><input type="text" name="email" size=16 maxlength=32></td>
          <td><input class="submit" type="submit" name="EmailSubmit" value="Next"></td>
        </form>
      </tr>
      <tr>
        <td>
          <front>Reset Password by user information</front>
        </td>
      </tr>
      <tr>
        <form name="Form" method=post action="validateReset.jsp">
          <td>
            <div align="right">
              <font face="Arial, Helvetica, sans-serif" size="2">User name:</font>
            </div>
          </td>
          <td><input type="text" name="username" size=16 maxlength=32></td>
      </tr>
      <tr>
        <td>
          <div align="right">
            <font face="Arial, Helvetica, sans-serif" size="2">Firstname:</font>
          </div>
        </td>
        <td><input type="text" name="firstname" size=16 maxlength=32></td>
      </tr>
      <tr>
        <td>
          <div align="right">
            <font face="Arial, Helvetica, sans-serif" size="2">Lastname:</font>
          </div>
        </td>
        <td><input type="text" name="lastname" size=16 maxlength=32></td>
        <td><input class="submit" type="submit" name="InfoSubmit" value="Next"></td>
        </form>
        <% if (session.getAttribute("errorMessage") !=null){ 
          String error_message = (String) session.getAttribute("errorMessage"); 
          out.println("<td><font color=\"" + "FF0000" + "\">" + error_message + "</font></td></tr>");
      }else{
      out.println("</tr>");
      }
      %>
    </table>

    <% if (session.getAttribute("errorMessage") !=null){ session.removeAttribute("errorMessage"); } %>


</body>

</html>