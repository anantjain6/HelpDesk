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
            <h2 class="float-left">Complaint</h2>
        </div>
        <div class="card-body">
            <%
            int complaint_id = Integer.parseInt(request.getParameter("id"));
        	Connection con = ConnectionProvider.getConnection();
    	    PreparedStatement ps = con.prepareStatement("select id,title,description,open,dept_id,category_id,user_id from complaints where id=?");
            ps.setInt(1, complaint_id);
    	    ResultSet rs = ps.executeQuery();
        	if (rs.next())
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
                <h4><%=rs.getString(2)%></h4>
                <%=rs.getString(3)%>
                <br><i class="fa fa-calendar"></i> <%= rs.getDate(4) %>
                <br><i class="fa fa-user"></i> <%= user %>
                <br><i class="fa fa-envelope"></i> <%= email %>
                <br><b>Department:</b> <%= department %>
                <br><b>Category:</b> <%= category %>
                <%
            }
            %>
        </div>
    </div>
    <br><br>
    <div class="card">
        <div class="card-header text-white shadow bg-dark">
            <h2 class="float-left">Resolve Complaint</h2>
        </div>
        <div class="card-body">
            <form action="ComplaintClose" method="post">
                <input type="hidden" name="complaintId" value="<%= complaint_id %>">
                <div class="form-group">
                    <label for="resolution" class="control-label">Resolution</label>
                    <textarea name="resolution" id="resolution" required></textarea>
                </div>
                <div class="form-group">
                    <input type="submit" class="btn btn-success btn-lg btn-block" value="Close Complaint">
                </div>
            </form>
        </div>
    </div>
    </main>
    
    <br><br><br>

    <script>
	var editor = CKEDITOR.replace( 'resolution', {
	    language: 'en',
	    extraPlugins: 'notification'
	});

	editor.on( 'required', function( evt ) {
		alert( 'Complaint resolution is required.' );
	    evt.cancel();
	} );
    </script>
    <%@include file="/includes/footer.jsp"%>
</body>
</html>