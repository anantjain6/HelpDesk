<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="util.ConnectionProvider,java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="/includes/head.jsp"%>
<link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
</head>
<body style="background-color: #f8f9fa !important;">
    <%@include file="/includes/header.jsp"%>
    <main role="main" class="container">
        <%@include file="/includes/msg.jsp"%>
        <div class="row row-cols-1 row-cols-md-3">
        <%
        int i = 0;
    	Connection con = ConnectionProvider.getConnection();
    	PreparedStatement ps = con.prepareStatement("select * from articles order by id desc");
    	ResultSet rs = ps.executeQuery();
    	while (rs.next())
        {
            i++;
            %>
              <div class="col mb-4">
                <div class="card h-100">
                  <div class="card-body">
                    <a href="article.jsp?id=<%= rs.getInt(1) %>"><h4 class="card-title"><%= rs.getString(2) %></h5></a>
                    <p class="card-text"><i class="fa fa-calendar"></i> <%= rs.getDate(5) %></p>
                  </div>
                </div>
              </div>
            <%
            if(i%3==0)
            {
                out.write("</div><div class=\"row row-cols-1 row-cols-md-3\">");   
            }
        }
        %>
        </div>
    </main>
    <%@include file="/includes/footer.jsp"%>
</body>
</html>