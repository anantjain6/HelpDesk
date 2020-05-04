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
            <h2 class="float-left">Add Category</h2>
        </div>
        <div class="card-body">
            <form action="CategoryAdd" method="post">
                <div class="form-group">
                    <label for="name" class="control-label">Category Name</label> <input type="text" name="name" id="name" class="form-control"
                        required>
                </div>
                <div class="form-group">
                    <label for="dept_id" class="control-label">Department</label>
                    <select name="dept_id" id="dept_id" class="form-control">
                    <%
        			Connection con=ConnectionProvider.getConnection();
        			PreparedStatement ps = con.prepareStatement("select id,name from departments order by name");
        			ResultSet rs = ps.executeQuery();
                    while(rs.next())
                    {
                    %>
                        <option value="<%= rs.getInt(1) %>"><%= rs.getString(2) %></option>
                    <%   
                    }
                    %>
                    </select>
                </div>
                <div class="form-group">
                    <label for="priority" class="control-label">Priority</label>
                    <select name="priority" id="priority" class="form-control">
                        <%
                        for(int i=0; i<=9; i++) {
                         out.write("<option value=\""+i+"\">"+(i*10)+"</option>");
                        }
                        %>
                    </select>
                </div>
                <div class="form-group">
                    <input type="submit" class="btn btn-success btn-lg btn-block" value="Add Category">
                </div>
            </form>
        </div>
    </div>
    </main>
    
    <br><br><br>

    <%@include file="/includes/footer.jsp"%>
</body>
</html>