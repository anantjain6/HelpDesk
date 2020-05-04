<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
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
            <h2 class="float-left">Change Password</h2>
        </div>
        <div class="card-body">
            <form action="ChangePassword" method="post">
                <div class="form-group">
                    <label for="oldPassword" class="control-label">Old Password</label> <input type="password" name="oldPassword" id="oldPassword" class="form-control"
                        required>
                </div>
                <div class="form-group">
                    <label for="newPassword" class="control-label">New Password</label> <input type="password" name="newPassword" id="newPassword" class="form-control"
                        required>
                </div>
                <div class="form-group">
                    <label for="confirmNewPassword" class="control-label">Confirm New Password</label> <input type="password" name="confirmNewPassword" id="confirmNewPassword" class="form-control"
                        required>
                </div>
                <div class="form-group">
                    <input type="submit" class="btn btn-success btn-lg btn-block" value="Change Password">
                </div>
            </form>
        </div>
    </div>
    </main>
    
    <br><br><br>
    <%@include file="/includes/footer.jsp"%>
</body>
</html>