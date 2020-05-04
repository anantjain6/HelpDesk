<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="util.ConnectionProvider,java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="/includes/head.jsp"%>
</head>
<body style="background-color: #f8f9fa !important;">
    <%@include file="/includes/header.jsp"%>
    <%
    Connection con = ConnectionProvider.getConnection();
	PreparedStatement ps = con.prepareStatement("select count(*) from complaints where status=0 and technician_id=?");
    ps.setInt(1, (int) session.getAttribute("id"));
	ResultSet rs = ps.executeQuery();
    int open = 0;
    int close = 0;
    int total = 0;
    if(rs.next()) {
     open = rs.getInt(1);   
    }
    ps = con.prepareStatement("select count(*) from complaints where status=1 and technician_id=?");
    ps.setInt(1, (int) session.getAttribute("id"));
    rs = ps.executeQuery();
    if(rs.next()) {
     close = rs.getInt(1);   
    }
    total = open + close;
    %>
    <main role="main" class="container">
        <%@include file="/includes/msg.jsp"%>
        <div class="row row-cols-1 row-cols-md-3">
            <div class="col mb-4">
                <div class="card text-white bg-warning mb-3">
                    <div class="card-header">Pending Complaints</div>
                    <div class="card-body text-center">
                        <h1 class="display-2"><%= open %></h1>
                    </div>
                </div>
            </div>
            <div class="col mb-4">
                <div class="card text-white bg-success mb-3">
                    <div class="card-header">Closed Complaints</div>
                    <div class="card-body text-center">
                        <h1 class="display-2"><%= close %></h1>
                    </div>
                </div>
            </div>
            <div class="col mb-4">
                <div class="card text-white bg-primary mb-3">
                    <div class="card-header">Total Complaints</div>
                    <div class="card-body text-center">
                        <h1 class="display-2"><%= total %></h1>
                    </div>
                </div>
            </div>
        </div>
    </main>
    <%@include file="/includes/footer.jsp"%>
</body>
</html>