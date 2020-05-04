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
            <h2 class="float-left">Edit Category</h2>
        </div>
        <% 
            String iD=request.getParameter("id");
            int id = Integer.parseInt(iD);
            Connection con=ConnectionProvider.getConnection();
            PreparedStatement ps = con.prepareStatement("select * from categories where id=?");

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            String name="";
            int dept_id=0;
            int priority=0;
            if(rs.next())
            {
                dept_id=rs.getInt(2);
                name=rs.getString(3);
                priority=rs.getInt(4);
            }
            %>
        <div class="card-body">
            <form action="CategoryEdit" method="post">
                <input type="hidden" name="id" value="<%= id %>">
                <div class="form-group">
                    <label for="name" class="control-label">Category Name</label> <input type="text" name="name" id="name" class="form-control"
                        required value="<%= name %>">
                </div>
                <div class="form-group">
                    <label for="dept_id" class="control-label">Department</label>
                    <select name="dept_id" id="dept_id" class="form-control">
                    <%
                    ps = con.prepareStatement("select id,name from departments order by name");
                    rs = ps.executeQuery();
                    while(rs.next())
                    {
                    %>
                        <option value="<%= rs.getInt(1) %>" <% if(rs.getInt(1)== dept_id) out.write("selected"); %>><%= rs.getString(2) %></option>
                    <%   
                    }
                    %>
                    </select>
                </div>
                <div class="form-group">
                    <label for="priority" class="control-label">Priority</label>
                    <input type="number" name="priority" id="priority" class="form-control" required value="<%= priority %>">
                </div>
                <div class="form-group">
                    <input type="submit" class="btn btn-success btn-lg btn-block" value="Update Category">
                </div>
            </form>
        </div>
    </div>
    </main>
    
    <br><br><br>

    <%@include file="/includes/footer.jsp"%>
</body>
</html>