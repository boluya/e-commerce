<%@ page language="java" import="java.io.*,java.sql.*"%>
<%@ include file="jdbc.jsp" %>
<!DOCTYPE html>
<head>
<title>Check Out</title>
</head>
<body>

<%@ page language="java" import="java.io.*,java.sql.*"%>

<%
    if (session.getAttribute("authenticatedUser") != null){

        String username = (String) session.getAttribute("authenticatedUser");
        out.println("<h3>complete your transaction</h3><table class=\"table\" border=\"1\"><form method=\"get\" action=\"order.jsp\"><tr><td>Check out as: </td><td>" + username + "</td></tr>");
        final int FIRSTNAME = 1, LASTNAME = 2, PHONE = 3, ADDRESS = 4, CITY = 5, STATE = 6, POST = 7, COUNTRY = 8;
        int customerId = -1;

        try{
            getConnection();
            Statement stmt = con.createStatement();
            stmt.execute("USE orders");
            String sql = "SELECT firstName, lastName, phonenum, address, city, state, postalCode, country, customerId FROM customer WHERE userid = ?";
            PreparedStatement pstmt = con.prepareStatement(sql);
            pstmt.setString(1, username);

            ResultSet rst = pstmt.executeQuery();
            rst.next();
            out.println("<tr><td>Shipping Address:</td></tr>");
            out.println("<tr><td>To:</td><td><input type=\"text\" name=\"address\" size=\"16\" value=\"" + rst.getString(FIRSTNAME) + " " + rst.getString(LASTNAME) + "\" required></td></tr>");
            out.println("<tr><td>cell:</td><td><input type=\"text\" name=\"address\" size=\"16\" value=\"" + rst.getString(PHONE) + "\" required></td></tr>");
            out.println("<tr><td>Address:</td><td><input type=\"text\" name=\"address\" size=\"16\" value=\"" + rst.getString(ADDRESS) + "\" required></td></tr>");
            out.println("<tr><td>City:</td><td><input type=\"text\" name=\"city\" size=\"16\" value=\"" + rst.getString(CITY) + "\" required></td></tr>");
            out.println("<tr><td>State:</td><td><input type=\"text\" name=\"state\" size=\"16\" value=\"" + rst.getString(STATE) + "\" required></td></tr>");
            out.println("<tr><td>Postal Code:</td><td><input type=\"text\" name=\"post\" size=\"16\" value=\"" + rst.getString(POST) + "\" required></td></tr>");
            out.println("<tr><td>Country:</td><td><input type=\"text\" name=\"county\" size=\"16\" value=\"" + rst.getString(COUNTRY) + "\" required></td></tr>");
            out.println("<tr><td>Customer Id:</td><td><input type=\"text\" name=\"customerId\" size=\"16\" required></td></tr>");
            out.println("<tr><td>Password:</td><td><input type=\"password\" name=\"password\" size=\"16\"  required></td></tr></table>");
            customerId = rst.getInt(9);

            con.close();
        }catch (SQLException ex) {
            out.println(ex);
        }
        try{
            String sql2 = "SELECT paymentMethodId, paymentType, paymentNumber, paymentExpiryDate FROM paymentmethod WHERE customerId = ?";
            Connection con2 = DriverManager.getConnection(url, uid, pw);
            PreparedStatement pstmt2 = con2.prepareStatement(sql2);
            pstmt2.setInt(1, customerId);
    
            ResultSet rst2 = pstmt2.executeQuery();
            while(rst2.next()){
                out.println("<br><table class=\"table\" border=\"1\"><tr><td>Patment Mothed:</td></tr>");
                out.println("<tr><td>Payment Type:</td><td>" + rst2.getString(2) + "</td></tr>");
                out.println("<tr><td>Payment Number:</td><td>" + rst2.getString(3) + "</td></tr>");
                out.println("<tr><td>Expiry Date:</td><td>****</td></tr>");
                out.println("<tr><td><form method=\"get\" action=\"order.jsp\"><input type=\"submit\" value=\"Checkout with this Payment Method\"></form></td></tr></table>"); 

            }
    
            con2.close();
        }catch (SQLException ex) {
            out.println(ex);
        }
        out.println("<br><table class=\"table\" border=\"1\"><tr><td>Add Patment Mothed:</td></tr>");
        out.println("<tr><td>Payment Type:</td><td><input type=\"text\" name=\"nptype\" size=\"16\" required></td></tr>");
        out.println("<tr><td>Payment Number:</td><td><input type=\"text\" name=\"npnum\" size=\"16\" required></td></tr>");
        out.println("<tr><td>Expiry Date:</td><td><input type=\"text\" name=\"nedate\" placeholder = \"YYYY-MM-DD\" size=\"16\" required></td></tr>");   
        out.println("<tr><td><input type=\"submit\" name=\"AddPayment\" value=\"Checkout with new Payment Method\"></td></tr></table></form>"); 

    }else{
        out.println("<table class=\"table\" border=\"1\"></table><form method=\"get\" action=\"login.jsp\"><h3>Login to check out</h3><input type=\"submit\" value=\"Login\"></form>");
    }
%>

</table>

</body>
</html>
