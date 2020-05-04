<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="util.ConnectionProvider,java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<form action="DepartmentEdit" method="post">
		<%
			int id = Integer.parseInt(request.getParameter("id"));
			Connection con=ConnectionProvider.getConnection();
			PreparedStatement ps = con.prepareStatement("select * from departments where id=?");

			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();
			String name="";
			if(rs.next())
			{
				name=rs.getString(2);
			}
		%>
		<input type="hidden" name="id" value="<%= id %>">
		name<input type="text" name="name" value="<%= name %>"><br />
		
		<br /> <input type="submit" value="Update">
	</form>


</body>
</html>