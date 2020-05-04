<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
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
            <h2 class="float-left">Date Range Complaint</h2>
        </div>
        <div class="card-body">
            <form action="day.jsp" method="get">
                <div class="form-group">
                    <label for="from" class="control-label">From</label>
                    <input type="date" name="from" id="from" class="form-control" required>
                </div>
                <div class="form-group">
                    <label for="to" class="control-label">To</label>
                    <input type="date" name="to" id="to" class="form-control" required>
                </div>
                <div class="form-group">
                    <label for="type" class="control-label">Report Type</label>
                    <select name="type" id="type" class="form-control">
                        <option value="summary">Summary</option>
                        <option value="detailed">Detaild</option>
                    </select>
                </div>
                <div class="form-group">
                    <input type="submit" class="btn btn-success btn-lg btn-block" value="Generate Report">
                </div>
            </form>
        </div>
    </div>
    </main>
    
    <br><br><br>
    <%@include file="/includes/footer.jsp"%>
</body>
</html>