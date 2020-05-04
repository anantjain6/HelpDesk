<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="util.ConnectionProvider,java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="/includes/head.jsp"%>
<script src="https://cdn.ckeditor.com/4.14.0/standard/ckeditor.js"></script>
</head>
<body style="background-color: #f8f9fa !important;">
    <%@include file="/includes/header.jsp"%>
    <main role="main" class="container"> <%@include file="/includes/msg.jsp"%>
    <div class="card">
        <%
            int id = Integer.parseInt(request.getParameter("id"));
            Connection con=ConnectionProvider.getConnection();
            PreparedStatement ps = con.prepareStatement("select * from articles where id=?");
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            String content="";
            String title="";
            if(rs.next())
            {
                title=rs.getString(2);
                content=rs.getString(3);
            }
        %>
        <div class="card-header text-white shadow bg-dark">
            <h2 class="float-left">Edit Articles</h2>
        </div>
        <div class="card-body">
            <form action="ArticleEdit" method="post">
                <input type="hidden" name="id" value="<%= id %>">
                <div class="form-group">
                    <label for="title" class="control-label">Title</label> <input type="text" name="title" id="title" class="form-control"
                         value="<%= title %>" required>
                </div>
                <div class="form-group">
                    <label for="content" class="control-label">Content</label>
                    <textarea name="content" id="content"><%= content %></textarea>
                </div>
                <div class="form-group">
                    <input type="submit" class="btn btn-success btn-lg btn-block" value="Update article">
                </div>
            </form>
        </div>
    </div>
    </main>
    
    <br><br><br>

    <script>
    CKEDITOR.replace('content');
    </script>
    <%@include file="/includes/footer.jsp"%>
</body>
</html>