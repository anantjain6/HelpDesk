<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="util.ConnectionProvider,java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="/includes/head.jsp"%>
<link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
</head>
<body style="background-color: #f8f9fa !important;">
    <div id="fb-root"></div>
    <script async defer crossorigin="anonymous" src="https://connect.facebook.net/en_GB/sdk.js#xfbml=1&version=v6.0"></script>
    <%@include file="/includes/header.jsp"%>
    <main role="main" class="container">
        <%@include file="/includes/msg.jsp"%>
        <%
        int i = 0;
        String uri = request.getScheme() + "://" +   // "http" + "://
                request.getServerName() +       // "myhost"
                ":" +                           // ":"
                request.getServerPort() +       // "8080"
                request.getRequestURI() +       // "/people"
                "?" +                           // "?"
                request.getQueryString();       // "lastname=Fox&age=30"
    	Connection con = ConnectionProvider.getConnection();
    	PreparedStatement ps = con.prepareStatement("select * from articles where id=?");
        ps.setInt(1, Integer.parseInt(request.getParameter("id")));
    	ResultSet rs = ps.executeQuery();
    	if (rs.next())
        {
        %>
        <div class="jumbotron p-4 p-md-5 text-white rounded bg-dark">
            <h1 style="font-family: 'Playfair Display', Georgia, 'Times New Roman', serif;" class="display-4 font-italic"><%= rs.getString(2) %></h1>
        </div>
        <div class="card">
            <div class="card-body text-center">
                <div class="addthis_inline_share_toolbox"></div>
            </div>
        </div>
        <br>
        <div class="card">
            <div class="card-body">
                <%= rs.getString(3) %>
            </div>
        </div>
        <% if(session.getAttribute("id") != null) {
        	PreparedStatement ps2 = con.prepareStatement("select * from ratings where user_id=? and article_id=?");
            ps2.setInt(1, (int) session.getAttribute("id"));
            ps2.setInt(2, Integer.parseInt(request.getParameter("id")));
            ResultSet rs2 = ps2.executeQuery();
            if(rs2.next()) {
            	PreparedStatement ps3 = con.prepareStatement("select avg(star) from ratings where article_id=?");
            	ps3.setInt(1, Integer.parseInt(request.getParameter("id")));
                ResultSet rs3 = ps3.executeQuery();
                if(rs3.next()) {
            %>
            <br>
            <div class="card">
                <div class="card-body text-center">
                    <h4>Rated <%= rs3.getDouble(1) %>/5</h4>
                </div>
            </div>
            <% }
            	
            } else {
        %>
        <br>
        <div class="card">
            <div class="card-body text-center">
                <h4>Rate this article</h4>
                <form action="RatingAdd" method="post">
                <input type="hidden" value="<%= request.getParameter("id") %>" name="articleId">
                <input type="radio" name="rating" value="1" id="1"> <label for="1">1</label> &nbsp; 
                <input type="radio" name="rating" value="2" id="2"> <label for="2">2</label> &nbsp; 
                <input type="radio" name="rating" value="3" id="3"> <label for="3">3</label> &nbsp; 
                <input type="radio" name="rating" value="4" id="4"> <label for="4">4</label> &nbsp; 
                <input type="radio" name="rating" value="5" id="5"> <label for="5">5</label> &nbsp; 
                <br><input type="submit" class="btn btn-success" value="Rate Now">
                </form>
            </div>
        </div>
        <% } } else {
        	PreparedStatement ps3 = con.prepareStatement("select avg(star) from ratings where article_id=?");
        	ps3.setInt(1, Integer.parseInt(request.getParameter("id")));
            ResultSet rs3 = ps3.executeQuery();
            if(rs3.next()) {
        %>
        <br>
        <div class="card">
            <div class="card-body text-center">
                <h4>Rated <%= rs3.getDouble(1) %>/5</h4>
            </div>
        </div>
        <% } } %>
        <br>
        <div class="card">
            <div class="card-body">
                <div class="fb-comments" data-href="<%= uri %>" data-width="100%" data-numposts="5"></div>
            </div>
        </div>
        <%
        }
        %>
        <br><br><br>
    </main>
    <%@include file="/includes/footer.jsp"%>
    <script type="text/javascript" src="//s7.addthis.com/js/300/addthis_widget.js#pubid=ra-5e7b3245f55102e8"></script>
</body>
</html>