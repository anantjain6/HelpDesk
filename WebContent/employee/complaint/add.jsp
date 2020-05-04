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
        <div class="card-header text-white shadow bg-dark">
            <h2 class="float-left">Lodge Complaint</h2>
        </div>
        <div class="card-body">
            <form action="ComplaintAdd" method="post">
                <div class="form-group">
                    <label for="title" class="control-label">Title</label> <input type="text" name="title" id="title" class="form-control"
                        required>
                </div>
                <div class="form-group">
                    <label for="description" class="control-label">Description</label>
                    <textarea name="description" id="description" required></textarea>
                </div>
                <input type="hidden" name="departments" value="<%= request.getParameter("dept_id") %>">
                <div class="form-group">
                    <label for="categories" class="control-label">Categories</label>
                    <select name="categories" id="categories" class="form-control">
                    <%
                    Connection con = ConnectionProvider.getConnection();
                    PreparedStatement ps=con.prepareStatement("select * from categories where dept_id=? order by name");
                    ps.setInt(1, Integer.parseInt(request.getParameter("dept_id")));
                    ResultSet rs=ps.executeQuery();
                    while(rs.next()) {
                    %>
                    <option value=" <%= rs.getInt(1) %> "> <%= rs.getString(3) %></option>
                    <% } %>
                    </select>
                </div>
                <div class="form-group">
                    <input type="submit" class="btn btn-success btn-lg btn-block" value="Lodge Complaint">
                </div>
            </form>
        </div>
    </div>
    </main>
    
    <br><br><br>

    <script>
	var editor = CKEDITOR.replace( 'description', {
	    language: 'en',
	    extraPlugins: 'notification'
	});

	editor.on( 'required', function( evt ) {
		alert( 'Complaint description is required.' );
	    evt.cancel();
	} );
    </script>
    <%@include file="/includes/footer.jsp"%>
</body>
</html>