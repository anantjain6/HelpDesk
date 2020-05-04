<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="util.ConnectionProvider,java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="/includes/head.jsp"%>
</head>
<body style="background-color: #f8f9fa !important;">
    <%@include file="/includes/header.jsp"%>
    <main role="main" class="container">
        <%@include file="/includes/msg.jsp"%>
        <%
        Connection con = ConnectionProvider.getConnection();
        PreparedStatement ps = con.prepareStatement("select * from faq order by id");
        ResultSet rs = ps.executeQuery();
        while (rs.next())
        {
        %>
            <div class="card">
                <div class="card-header">
                    <%= rs.getString(2) %>
                </div>
                <div class="card-body">
                    <%= rs.getString(3) %>
                </div>
            </div>
            <br><br>
        <%   
        }
        %> 
        <br><br><br>
    </main>
    <%@include file="/includes/footer.jsp"%>
</body>
</html>