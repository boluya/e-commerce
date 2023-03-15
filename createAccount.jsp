
<!DOCTYPE html>
<html>
<head>
<title>Create Account Page</title>
</head>
<body>
<H1 align="center"><font color="#3399FF"><a href="index.jsp">HOME</a></font></H1>  

<%@ page language="java" import="java.io.*,java.sql.*"%>

<%
final int USERNAME = 0, PASSWORD = 1, PASSWORD_R = 2, EMAIL = 3, EMAIL_R = 4, PHONE = 5, ADDRESS = 6, CITY = 7, STATE = 8, POST = 9, COUNTRY = 10, FIRSTNAME = 11, LASTNAME = 12;
final String[] INFO =       {"userName", "password", "password_r", "email", "email_r", "phone", "address", "city", "state", "post", "country", "firstName", "lastName"};
final String[] INPUT_MESSAGE = {"user name:", "Password:", "Confirm Password:", "Email:", "Confirm Email:", "Phone Number:", "Address:", "City:", "State:", "Postal Code:", "Country:", "firstName:", "lastName:"};
session = request.getSession(true);
%>



<br>
<form name="Form" method=post action="validateCreate.jsp">
<table border="1">

<%
String[] error_message = new String[13];
String[] user_info = new String[13];
if (session.getAttribute("errorMessage") != null){
	error_message = (String [])session.getAttribute("errorMessage");
}
if (session.getAttribute("newAccountInfo") != null){
	user_info = (String [])session.getAttribute("newAccountInfo");
}

for(int i = 0; i < INFO.length; i++){
	out.println("<tr>");
	out.println("<th>" + INPUT_MESSAGE[i] + "</th>");
	
	if(i == PASSWORD || i == PASSWORD_R){
		if(error_message[i] != null && error_message[i].compareTo(" ") != 0){
			out.println("<td><input type=\"password\" name=\"" + INFO[i] + "\" placeholder=\"" + error_message[i] + "\" size=16 maxlength=\"12\" required></td>");
		}else{
			out.println("<td><input type=\"password\" name=\"" + INFO[i] + "\" size=16 maxlength=\"12\" required></td>");
		}
	}else{
		if(user_info[i] != null){
			if(error_message[i] != null && error_message[i].compareTo(" ") != 0){
				out.println("<td><input type=\"text\" name=\"" + INFO[i] + "\" placeholder=\"" + error_message[i] + "\" size=16 maxlength=32 required></td>");
			}else{
				out.println("<td><input type=\"text\" value = \"" + user_info[i] + "\" name=\"" + INFO[i] + "\"  size=16 maxlength=32 required></td>");
			}
		}else{
			if(error_message[i] != null && error_message[i].compareTo(" ") != 0){
				out.println("<td><input type=\"text\" name=\"" + INFO[i] + "\"  placeholder=\"" + error_message[i] + "\" size=16 maxlength=32 required></td>");
			}else{
				out.println("<td><input type=\"text\" name=\"" + INFO[i] + "\"  size=16 maxlength=32 required></td>");
			}
		}
	}

	out.println("</tr>");
}

if (session.getAttribute("errorMessage") != null){
	session.removeAttribute("errorMessage");
}
if (session.getAttribute("newAccountInfo") != null){
	session.removeAttribute("newAccountInfo");
}

%>


</table>
<br>
<input class="submit" type="submit" name="Submit" value="Sign Up">
</form>



</body>
</html>