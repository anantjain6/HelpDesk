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
            <h2 class="float-left">Add Articles</h2>
        </div>
        <div class="card-body">
            <form action="ArticleAdd" method="post">
                <div class="form-group">
                    <label for="title" class="control-label">Title</label> <input type="text" name="title" id="title" class="form-control"
                        required>
                </div>
                <div class="form-group">
                    <label for="content" class="control-label">Content</label>
                    <textarea name="content" id="content" required></textarea>
                </div>
                <div class="form-group">
                    <input type="submit" class="btn btn-success btn-lg btn-block" value="Add Article">
                </div>
            </form>
        </div>
    </div>
    </main>
    
    <br><br><br>

    <script>
	var editor = CKEDITOR.replace( 'content', {
	    language: 'en',
	    extraPlugins: 'notification'
	});

	editor.on( 'required', function( evt ) {
		alert( 'Article content is required.' );
	    evt.cancel();
	} );
	</script>
    <%@include file="/includes/footer.jsp"%>
</body>
</html>