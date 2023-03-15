<%@ page language="java" import="java.io.*,java.sql.*"%>
<%@ page import="java.lang.*" %>
<%@ page import="java.util.*" %>
<%@ page import = "java.io.*,java.util.*,javax.mail.*"%>
<%@ page import = "javax.mail.internet.*,javax.activation.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*" %>
<%@ include file="jdbc.jsp" %>

<!DOCTYPE html>
<html>
<head>
<title>Validate Account Page</title>
</head>
<body>
<H1 align="center"><font color="#3399FF"><a href="index.jsp">HOME</a></font></H1>    
<% 
    String email = "";
    String username = "";
    String firstname = "";
    String lastname = "";
    String defaultPassword = "1234567";

    session = request.getSession(true);
    if(request.getParameter("email") != null){
        email = request.getParameter("email");
    }
    if(request.getParameter("username") != null){
        username = request.getParameter("username");
    }
    if(request.getParameter("firstname") != null){
        firstname = request.getParameter("firstname");
    }
    if(request.getParameter("lastname") != null){
        lastname = request.getParameter("lastname");
    }

    if(request.getParameter("email") == null){

        String sql = "SELECT firstName, lastName, userid FROM customer WHERE userid = ?";
        String error_message = "";

        try{ 
            getConnection();
            Statement stmt = con.createStatement(); 			
            stmt.execute("USE orders");
            PreparedStatement pstmt = con.prepareStatement(sql);
            pstmt.setString(1, username);
            ResultSet rst = pstmt.executeQuery();
            if(rst.next()){
                boolean valid = true;
                if(!firstname.equals(rst.getString(1))){
                    valid = false;
                }
                if(!lastname.equals(rst.getString(2))){
                    valid = false;
                }
                if(valid){
                    sql = "UPDATE customer SET password = ? WHERE userid = ?";
                    pstmt = con.prepareStatement(sql);
                    pstmt.setString(2, username);
                    pstmt.setString(1, defaultPassword);
                    pstmt.executeUpdate();
                    out.println("<h3>Your password has been set to the default: " + defaultPassword + "</h3>");
                    out.println("<form name=\"Form\" method=post action=\"login.jsp\"><input class=\"submit\" type=\"submit\" name=\"Submit\" value=\"Login\"></form>");
                }else{
                    error_message = "There is no account corresponding to the entered information";
                    session.setAttribute("errorMessage", error_message);
                    response.sendRedirect("forgotPassword.jsp");
                }
            }else{
                if(!firstname.equals("") && !firstname.equals("") && !firstname.equals("")){
                    error_message = "There is no account corresponding to the entered information";
                    session.setAttribute("errorMessage", error_message);
                    response.sendRedirect("forgotPassword.jsp");
                }else{
                    error_message = "Missing information";
                    session.setAttribute("errorMessage", error_message);
                    response.sendRedirect("forgotPassword.jsp");
                }
            }
        }catch (SQLException ex) {
            out.println(ex);
        }
        finally{
            closeConnection();
        }
    }else if(request.getParameter("EmailSubmit") != null){
        String sql = "UPDATE customer SET password = ? WHERE email = ?";
        String error_message = "";

        try{ 
            getConnection();
            Statement stmt = con.createStatement(); 			
            stmt.execute("USE orders");
            PreparedStatement pstmt = con.prepareStatement(sql);
            pstmt.setString(2, email);
            pstmt.setString(1, defaultPassword);
            int isValid = pstmt.executeUpdate();
            if(isValid != 0){
                    out.println("<h3>Your password has been set to the default: " + defaultPassword + "</h3>");
                    out.println("<form name=\"Form\" method=post action=\"login.jsp\"><input class=\"submit\" type=\"submit\" name=\"Submit\" value=\"Login\"></form>");
            }else
                out.println("No account was found associated witht he email provided");
        }catch (SQLException ex) {
            out.println(ex);
        }
        finally{
            closeConnection();
        }
    }
    
%>



</body>
</html>