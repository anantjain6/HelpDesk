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
            <h2 class="float-left">Assigned Complaints</h2>
        </div>
        <div class="card-body">
            <table class="table table-hover">
                <thead>
                    <tr>
                        <th scope="col">ID</th>
                        <th scope="col">Complaint</th>
                        <th scope="col">Priority</th>
                        <th scope="col">Action</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                    	Connection con = ConnectionProvider.getConnection();
                	    PreparedStatement ps = con.prepareStatement("select cp.id,title,description,open,cp.dept_id,category_id,user_id,((ct.priority * 10) + cp.priority) p from complaints cp,categories ct where cp.category_id=ct.id and status=0 and technician_id=? order by p desc");
                        ps.setInt(1, (int) session.getAttribute("id"));
                	    ResultSet rs = ps.executeQuery();
                    	while (rs.next())
                        {
                            PreparedStatement ps2 = con.prepareStatement("select name from categories where id=?");
                            ps2.setInt(1, rs.getInt(6));
                            ResultSet rs2 = ps2.executeQuery();
                            String category = "";
                            if(rs2.next()) {
                                category = rs2.getString(1);
                            }
                            PreparedStatement ps3 = con.prepareStatement("select name from departments where id=?");
                            ps3.setInt(1, rs.getInt(5));
                            ResultSet rs3 = ps3.executeQuery();
                            String department = "";
                            if(rs3.next()) {
                                department = rs3.getString(1);
                            }
                            PreparedStatement ps4 = con.prepareStatement("select name,email from users where id=?");
                            ps4.setInt(1, rs.getInt(7));
                            ResultSet rs4 = ps4.executeQuery();
                            String user = "";
                            String email = "";
                            if(rs4.next()) {
                                user = rs4.getString(1);
                                email = rs4.getString(2);
                            }
                        %>
                        <tr>
                            <th scope="row"><%=rs.getInt(1)%></th>
                            <td>
                                <h4><%=rs.getString(2)%></h4>
                                <%=rs.getString(3)%>
                                <br><i class="fa fa-calendar"></i> <%= rs.getDate(4) %>
                                <br><i class="fa fa-user"></i> <%= user %>
                                <br><i class="fa fa-envelope"></i> <%= email %>
                                <br><b>Department:</b> <%= department %>
                                <br><b>Category:</b> <%= category %>
                            </td>
                            <td><%= rs.getInt(8) %></td>
                            <td><a class="btn btn-danger" href="close.jsp?id=<%= rs.getInt(1) %>" role="button">Resolve</a></td>
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