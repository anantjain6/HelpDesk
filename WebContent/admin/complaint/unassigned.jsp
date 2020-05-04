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
            <h2 class="float-left">Unassigned Complaints</h2>
        </div>
        <div class="card-body">
            <table class="table table-hover">
                <thead>
                    <tr>
                        <th scope="col">ID</th>
                        <th scope="col">Complaint</th>
                        <th scope="col">Assign</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                    	Connection con = ConnectionProvider.getConnection();
                	    PreparedStatement ps=con.prepareStatement("select * from users where user_type=1 order by name");
                	    ResultSet rs=ps.executeQuery();
                        String tech = "";
                	    while(rs.next())
                	    {
                	       tech = tech + "<option value=\"" + rs.getInt(1) + "\">" + rs.getString(3) + "</option>";
                	    }
                    	ps = con.prepareStatement("select id,title,description,open,dept_id,category_id,user_id from complaints where technician_id is null order by id desc");
                    	rs = ps.executeQuery();
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
                                <a href="<%=request.getContextPath()%>/admin/complaint/view.jsp?id=<%=rs.getInt(1)%>"><h4><%=rs.getString(2)%></h4></a>
                                <%=rs.getString(3)%>
                                <br><i class="fa fa-calendar"></i> <%= rs.getDate(4) %>
                                <br><i class="fa fa-user"></i> <%= user %>
                                <br><i class="fa fa-envelope"></i> <%= email %>
                                <br><b>Department:</b> <a target="_blank" href="<%= request.getContextPath() %>/admin/report/department.jsp?id=<%= rs.getInt(5) %>"><%= department %></a>
                                <br><b>Category:</b>  <a target="_blank" href="<%= request.getContextPath() %>/admin/report/category.jsp?id=<%= rs.getInt(6) %>"><%= category %></a>
                            </td>
                            <td>
                            <form action="ComplaintAssign" method="post">
                            <input type="hidden" name="complaintId" value="<%=rs.getInt(1)%>" class="form-control"><br>
                            <select name="technicianId" class="form-control"><%= tech %></select><br>
                            <select name="priority" class="form-control">
                            <%
                            for(int i=0; i<=9; i++) {
                             out.write("<option value=\""+i+"\">"+i+"</option>");
                            }
                            %>
                            </select>
                            <br>
                            <input type="submit" class="btn btn-danger" value="Assign">
                            </form>
                            </td>
                        </tr>
                        <%   
                        }
                    %>
                </tbody>
            </table>
        </div>
        <br><br><br>
    </div>
    </main>
    <%@include file="/includes/footer.jsp"%>
</body>
</html>