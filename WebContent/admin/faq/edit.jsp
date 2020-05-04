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
            <h2 class="float-left">Edit FAQ</h2>
        </div>
        <%
            int id = Integer.parseInt(request.getParameter("id"));

            Connection con = ConnectionProvider.getConnection();

            PreparedStatement ps = con.prepareStatement("select * from faq where id=?");
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            String question = "";
            String answer = "";

            if (rs.next()) {
                question = rs.getString(2);
                answer = rs.getString(3);
            }
        %>
        <div class="card-body">
            <form action="FaqEdit" method="post">
                <input type="hidden" name="id" value="<%= id%>">
                <div class="form-group">
                    <label for="question" class="control-label">Question</label> <input type="text" name="question" id="question" class="form-control"
                         value="<%=question %>" required>
                </div>
                <div class="form-group">
                    <label for="content" class="control-label">Answer</label>
                    <textarea name="answer" id="answer"><%=answer %></textarea>
                </div>
                <div class="form-group">
                    <input type="submit" class="btn btn-success btn-lg btn-block" value="Update FAQ">
                </div>
            </form>
        </div>
    </div>
    </main>
    
    <br><br><br>

    <script>
    CKEDITOR.replace('answer');
    </script>
    <%@include file="/includes/footer.jsp"%>
</body>
</html>