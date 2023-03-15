<%@ page language="java" import="java.io.*,java.sql.*"%>
<%@ page import="java.lang.*" %>
<%@ page import="java.util.*" %>
<%@ page language="java" import="java.io.*,java.sql.*" %>
<%@ include file="jdbc.jsp" %>
<!DOCTYPE html>
<html>
<head>
<title>Validate Account Page</title>
</head>
<body>

<% 
    session = request.getSession(true);
    final int USERNAME = 0, PASSWORD = 1, PASSWORD_R = 2, EMAIL = 3, EMAIL_R = 4, PHONE = 5, ADDRESS = 6, CITY = 7, STATE = 8, POST = 9, COUNTRY = 10, FIRSTNAME = 11, LASTNAME = 12;
    final String[] INFO ={"userName", "password", "password_r", "email", "email_r", "phone", "address", "city", "state", "post", "country", "firstName", "lastName"};
    boolean valid = true;
    String[] error_message = {" ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " "};

    String[] userInfo = new String[13];

    for(int i = 0; i < userInfo.length; i++){
        userInfo[i] = request.getParameter(INFO[i]);
    }

    //Check email validation
    boolean validEmail = false;
    for(int i = 0; i < userInfo[EMAIL].length(); i++){
        if(userInfo[EMAIL].charAt(i) == '@'){
            validEmail = true;
            break;
        }
    }

    if(!validEmail){
        valid = false;
        error_message[EMAIL] = "Invalid email";
    }

    //Check if passwords are same
    if(userInfo[PASSWORD].compareTo(userInfo[PASSWORD_R]) != 0){
        valid = false;
        error_message[PASSWORD_R] = "Retyped incorrectly";
    }

    //Check if email are same
    if(userInfo[EMAIL].compareTo(userInfo[EMAIL_R]) != 0){
        valid = false;
        error_message[EMAIL_R] = "Retyped incorrectly";
    }

    //Check empty
    for(int i = 0; i < userInfo.length; i++){
        if(userInfo[i].compareTo("") == 0 || userInfo[i].equals(null)){
            valid = false;
            error_message[i] = "Required field";
        }
    }

    //Check if username taken
    try{
        getConnection();
        Statement stmt = con.createStatement(); 
        stmt.execute("USE orders");
        String sql2 = "SELECT userid FROM customer";
        PreparedStatement pstmt2 = con.prepareStatement(sql2);
        ResultSet rst = pstmt2.executeQuery();

        while(rst.next()){
            if(userInfo[USERNAME].equals(rst.getString(1))){
                valid = false;
                error_message[USERNAME] = "Username taken";
                break;
            }
        }

    }
		catch (SQLException ex) {
      out.println("FIRST LOOP");
			out.println(ex);
		}
		finally
		{
			closeConnection();
		}	

    if(valid){
        String sql = "INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try{ 
            getConnection();
            Statement stmt = con.createStatement(); 
            stmt.execute("USE orders");
            PreparedStatement pstmt = con.prepareStatement(sql);
            pstmt.setString(1, userInfo[FIRSTNAME]);
            pstmt.setString(2, userInfo[LASTNAME]);
            pstmt.setString(3, userInfo[EMAIL]);
            pstmt.setString(4, userInfo[PHONE]);
            pstmt.setString(5, userInfo[ADDRESS]);
            pstmt.setString(6, userInfo[CITY]);
            pstmt.setString(7, userInfo[STATE]);
            pstmt.setString(8, userInfo[POST]);
            pstmt.setString(9, userInfo[COUNTRY]);
            pstmt.setString(10, userInfo[USERNAME]);
            pstmt.setString(11, userInfo[PASSWORD]);

            pstmt.executeUpdate();
        }
        catch (SQLException ex) {
          out.println("SECND LOOP");
          out.println(ex);
        }
        finally
        {
          closeConnection();
        }
        session.setAttribute("username", userInfo[USERNAME]);
        response.sendRedirect("login.jsp");
    }else{
        session.setAttribute("errorMessage", error_message);
        session.setAttribute("newAccountInfo", userInfo);
	    response.sendRedirect("createAccount.jsp");
    }
%>
</body>
</html>