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
            <h2 class="float-left">Complaints</h2>
            <button class="btn-success btn-lg float-right"  data-toggle="modal" data-target="#staticBackdrop" style="text-decoration: none;"> <i class="fa fa-plus"></i>
                Lodge New Complaint
            </button>
        </div>
        <div class="card-body">
            <table class="table table-hover">
                <thead>
                    <tr>
                        <th scope="col">ID</th>
                        <th scope="col">Complaint</th>
                        <th scope="col">Status</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                    	Connection con = ConnectionProvider.getConnection();
                	    PreparedStatement ps = con.prepareStatement("select id,title,description,open,status from complaints where user_id=? order by id desc");
                        ps.setInt(1, (int) session.getAttribute("id"));
                	    ResultSet rs = ps.executeQuery();
                    	while (rs.next())
                        {
                            String status = "";
                            if(rs.getInt(5) == 0)
                                status = "Pending";
                            else
                                status = "Closed";
                        %>
                        <tr>
                            <th scope="row"><%=rs.getInt(1)%></th>
                            <td><h4><%=rs.getString(2)%></h4><%=rs.getString(3)%><br><i class="fa fa-calendar"></i> <%= rs.getDate(4) %></td>
                            <td><%= status %></td>
                        </tr>
                        <%   
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>
    <br><br><br>
    </main>
    <%@include file="/includes/footer.jsp"%>
    
    <!-- Modal -->
<div class="modal fade" id="staticBackdrop" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="staticBackdropLabel">Select the department for which you want to lodge new complaint</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <%
        ps = con.prepareStatement("select id,name from departments order by name");
        rs = ps.executeQuery();
        while(rs.next()) {
         %>
         <a href="add.jsp?dept_id=<%= rs.getInt(1) %>"><%= rs.getString(2) %></a><br>
         <%   
        }
        %>
      </div>
    </div>
  </div>
</div>
</body>
</html>