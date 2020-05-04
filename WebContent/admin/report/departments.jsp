<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="util.ConnectionProvider,java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="/includes/head.jsp"%>
</head>
<body style="background-color: #f8f9fa !important;">
    <%@include file="/includes/header.jsp"%>
    <main role="main" class="container"> <%@include file="/includes/msg.jsp"%>
    <div class="card">
        <div class="card-header text-white shadow bg-dark">
            <h2 class="float-left">Department wise Complaints</h2>
        </div>
        <div class="card-body">
            <table class="table table-hover">
                <thead>
                    <tr>
                        <th scope="col">ID</th>
                        <th scope="col">Name</th>
                        <th scope="col">Pending<br>Complaints</th>
                        <th scope="col">Closed<br>Complaints</th>
                        <th scope="col">Total<br>Complaints</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                    	Connection con = ConnectionProvider.getConnection();
                    	PreparedStatement ps = con.prepareStatement("select dept_id,count(dept_id) c from complaints group by dept_id order by c desc");
                    	ResultSet rs = ps.executeQuery();
                    	while (rs.next())
                        {
                            int total = rs.getInt(2);
                            int open = 0;
                            int close = 0;
                        	PreparedStatement ps2 = con.prepareStatement("select count(dept_id) from complaints where status=0 and dept_id=?");
                            ps2.setInt(1, rs.getInt(1));
                        	ResultSet rs2 = ps2.executeQuery();
                            if(rs2.next()) {
                             open = rs2.getInt(1);   
                            }
                            close = total - open;
                            
                            String name = "";

                        	PreparedStatement ps3 = con.prepareStatement("select name from departments where id=?");
                            ps3.setInt(1, rs.getInt(1));
                        	ResultSet rs3 = ps3.executeQuery();
                            if(rs3.next()) {
                             name = rs3.getString(1);   
                            }
                        %>
                        <tr>
                            <th scope="row"><%=rs.getInt(1)%></th>
                            <td><a href="department.jsp?id=<%=rs.getInt(1)%>"><%=name%></a></td>
                            <td><%=open%></td>
                            <td><%=close%></td>
                            <td><%=total%></td>
                        </tr>
                        <%   
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>
    <br><br><br>
    </main>
    <%@include file="/includes/footer.jsp"%>
</body>
</html>