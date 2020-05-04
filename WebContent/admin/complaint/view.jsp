<%@page import="sun.security.action.PutAllAction"%>
<%@page import="oracle.net.aso.e"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="util.ConnectionProvider,java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="/includes/head.jsp"%>
<script src="https://cdn.ckeditor.com/4.14.0/standard/ckeditor.js"></script>
</head>
<body style="background-color: #f8f9fa !important;">
    <%@include file="/includes/header.jsp"%>
    <main role="main" class="container">
    <%@include file="/includes/msg.jsp"%>
    
    <div class="card">
        <div class="card-header text-white shadow bg-dark">
            <h2 class="float-left">Complaint</h2>
        </div>
        <div class="card-body">
            <%
            int complaint_id = Integer.parseInt(request.getParameter("id"));
        	Connection con = ConnectionProvider.getConnection();
    	    PreparedStatement ps = con.prepareStatement("select * from complaints where id=?");
            ps.setInt(1, complaint_id);
    	    ResultSet rs = ps.executeQuery();
        	if (rs.next())
            {
                PreparedStatement ps2 = con.prepareStatement("select name,priority from categories where id=?");
                ps2.setInt(1, rs.getInt(5));
                ResultSet rs2 = ps2.executeQuery();
                String category = "";
                if(rs2.next()) {
                    category = rs2.getString(1);
                }
                PreparedStatement ps3 = con.prepareStatement("select name from departments where id=?");
                ps3.setInt(1, rs.getInt(4));
                ResultSet rs3 = ps3.executeQuery();
                String department = "";
                if(rs3.next()) {
                    department = rs3.getString(1);
                }
                PreparedStatement ps4 = con.prepareStatement("select name,email from users where id=?");
                ps4.setInt(1, rs.getInt(6));
                ResultSet rs4 = ps4.executeQuery();
                String user = "";
                String email = "";
                if(rs4.next()) {
                    user = rs4.getString(1);
                    email = rs4.getString(2);
                }
                
                %>
                <h4><%=rs.getString(2)%></h4>
                <%=rs.getString(3)%>
                <br><i class="fa fa-calendar"></i> <%= rs.getDate(7) %>
                <br><i class="fa fa-user"></i> <%= user %>
                <br><i class="fa fa-envelope"></i> <%= email %>
                <br><b>Department:</b> <%= department %>
                <br><b>Category:</b> <%= category %>
                <%
                
                if(rs.getInt(9) != 0)
                {
                    PreparedStatement ps5 = con.prepareStatement("select name,email from users where id=?");
                    ps5.setInt(1, rs.getInt(9));
                    ResultSet rs5 = ps5.executeQuery();
                    String tech = "";
                    String tech_email = "";
                    if(rs5.next()) {
                        tech = rs5.getString(1);
                        tech_email = rs5.getString(2);
                    }
                    %>
                    
                    <hr>
                    <b>Technician Details:-</b>
                    <br><i class="fa fa-user"></i> <%= tech %>
                    <br><i class="fa fa-envelope"></i> <%= tech_email %>
                                    
                    <%
                    if(rs.getInt(12) == 0)
                    {
                        out.write("<hr><h4>Complaint is pending with priority "+(rs2.getInt(2) * 10 + rs.getInt(10))+"/99</h4>");
                    }
                }
                else
                {
                    out.write("<hr><i>No technician assigned</i>");
                }

                if(rs.getInt(12) == 1)  
                {
                    %>
                            </div>
                        </div>
                        <br><br>
                        <div class="card">
                            <div class="card-header text-white shadow bg-dark">
                                <h2 class="float-left">Resolution</h2>
                            </div>
                            <div class="card-body">
                                <%=rs.getString(11)%>
                                <br><i class="fa fa-calendar"></i> <%= rs.getDate(8) %>
                    <%
                }
            }
        	else
            {
                out.write("<i class=\"text-center\">Complaint not found</i>");
            }
            %>
        </div>
    </div>
    </main>
    
    <br><br><br>

    <%@include file="/includes/footer.jsp"%>
</body>
</html>