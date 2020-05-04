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
            <h2 class="float-left">Complaints</h2>
        </div>
        <div class="card-body">
            <%
            if(request.getParameter("type").equals("summary"))
            {
            %>

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
                    	PreparedStatement ps = con.prepareStatement("select dept_id,count(dept_id) c from complaints where open between to_date(?,'yyyy-mm-dd') and to_date(?,'yyyy-mm-dd') group by dept_id order by c desc");
                    	ps.setString(1, request.getParameter("from"));
                    	ps.setString(2, request.getParameter("to"));
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
            
            <%
            }
            else
            {
            %>
            
            <table class="table table-hover">
                <thead>
                    <tr>
                        <th scope="col">ID</th>
                        <th scope="col">Complaint</th>
                        <th scope="col">Open<br>Date</th>
                        <th scope="col">Close<br>Date</th>
                        <th scope="col">Time<br>Taken</th>
                        <th scope="col">Priority<br>(Max 99)</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                    	Connection con = ConnectionProvider.getConnection();
                    	PreparedStatement ps = con.prepareStatement("select cp.id,title,description,open,technician_id,cp.dept_id,user_id,((cp.priority * 10) + ct.priority) p,name,ct.id,close,nvl(trunc(close-open), -1) from complaints cp,categories ct where  open between to_date(?,'yyyy-mm-dd') and to_date(?,'yyyy-mm-dd') and cp.category_id=ct.id and technician_id is not null order by open desc");
                    	ps.setString(1, request.getParameter("from"));
                    	ps.setString(2, request.getParameter("to"));
                        ResultSet rs = ps.executeQuery();
                    	while (rs.next())
                        {
                            PreparedStatement ps2 = con.prepareStatement("select name from departments where id=?");
                            ps2.setInt(1, rs.getInt(6));
                            ResultSet rs2 = ps2.executeQuery();
                            String department = "";
                            if(rs2.next()) {
                            	department = rs2.getString(1);
                            }
                            PreparedStatement ps3 = con.prepareStatement("select name from users where id=?");
                            ps3.setInt(1, rs.getInt(5));
                            ResultSet rs3 = ps3.executeQuery();
                            String technician = "";
                            if(rs3.next()) {
                            	technician = rs3.getString(1);
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
                                <br><i class="fa fa-user"></i> <%= user %>
                                <br><i class="fa fa-envelope"></i> <%= email %>
                                <br><b>Emp Department:</b>  <a target="_blank" href="<%= request.getContextPath() %>/admin/report/department.jsp?id=<%= rs.getInt(6) %>"><%= department %></a>
                                <br><b>Technician:</b> <a target="_blank" href="<%= request.getContextPath() %>/admin/report/technician.jsp?id=<%= rs.getInt(5) %>"><%= technician %></a>
                                <br><b>Category:</b>  <a target="_blank" href="<%= request.getContextPath() %>/admin/report/category.jsp?id=<%= rs.getInt(10) %>"><%= rs.getString(9) %></a>
                            </td>
                            <td><%= rs.getDate(4) %></td>
                            <td><%= rs.getDate(11) %></td>
                            <td><%
                                if(rs.getInt(12) == -1) {
                                    out.write("--");
                                } else {
                                	%> <%= rs.getInt(12) %> <%
                                }
                                %>
                            </td>
                            <td><%= rs.getInt(8) %></td>
                        </tr>
                        <%   
                        }
                    %>
                </tbody>
            </table>
            
            <%
            }
            %>
            
        </div>
    </div>
    <br><br><br>
    </main>
    <%@include file="/includes/footer.jsp"%>
</body>
</html>