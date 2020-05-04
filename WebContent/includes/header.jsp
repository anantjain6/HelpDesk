<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<button onclick="topFunction()" id="myBtn" title="Go to top"><i class="fa fa-arrow-up"></i></button>

<nav class="navbar navbar-expand-lg navbar-dark bg-primary sticky-top shadow p-3 mb-5">
    <div class="container">
        <a class="navbar-brand" href="<%=request.getContextPath()%>"><img src="<%=request.getContextPath()%>/logo.png"></a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
            aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav mr-auto">

                <%
                	if (session.getAttribute("usertype") != null) {
                		if ((int) session.getAttribute("usertype") == 2) {
                        %>
                <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/admin/home.jsp">Home</a></li>
                <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/admin/user/show.jsp">Users</a></li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown2" role="button"
                    data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> Complaint </a>
                    <div class="dropdown-menu" aria-labelledby="navbarDropdown2">
                        <a class="dropdown-item" href="<%=request.getContextPath()%>/admin/complaint/unassigned.jsp">Unassigned Complaint</a>
                        <div class="dropdown-divider"></div>
                        <a class="dropdown-item" href="<%=request.getContextPath()%>/admin/report/pending.jsp">Pending & Assigned Complaint Report</a>
                        <a class="dropdown-item" href="<%=request.getContextPath()%>/admin/report/days.jsp">Date range Report</a>
                        <a class="dropdown-item" href="<%=request.getContextPath()%>/admin/report/departments.jsp">Department wise Complaint Report</a>
                        <a class="dropdown-item" href="<%=request.getContextPath()%>/admin/report/technicians.jsp">Technician wise Complaint Report</a>
                        <a class="dropdown-item" href="<%=request.getContextPath()%>/admin/report/categories.jsp">Category wise Complaint Report</a>
                        <div class="dropdown-divider"></div>
                        <div class="dropdown-item">
                            <form action="<%=request.getContextPath()%>/admin/complaint/view.jsp">
                                <div class="input-group mb-3">
                                  <input type="number" class="form-control" placeholder="Complaint ID" aria-label="Complaint ID" aria-describedby="button-addon2" name="id" required>
                                  <div class="input-group-append">
                                    <button class="btn btn-outline-secondary" type="submit" id="button-addon2">Search</button>
                                  </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </li>
                <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/admin/department/show.jsp">Departments</a></li>
                <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/admin/category/show.jsp">Categories</a></li>
                <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/admin/article/show.jsp">Articles</a></li>
                <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/admin/faq/show.jsp">FAQ</a></li>
                       <%
                	   }
                		else if ((int) session.getAttribute("usertype") == 0) {
                        %>
                        <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/employee/complaint/show.jsp">Complaint</a></li>
                        <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/knowledgebase">Knowledge Base</a></li>
                        <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/faq.jsp">FAQ</a></li>
                        <%         
                        }
                        else if ((int) session.getAttribute("usertype") == 1) {
                        %>
                        <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/technician/complaint/show.jsp">Complaint</a></li>
                        <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/knowledgebase">Knowledge Base</a></li>
                        <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/faq.jsp">FAQ</a></li>
                        <%         
                        }
                	}
                    else
                    {
                        %>
                        <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/knowledgebase">Knowledge Base</a></li>
                        <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/faq.jsp">FAQ</a></li>
                        <%
                    }
                %>
                <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/feedback.jsp">Feedback</a></li>
            </ul>
            <%
            	if (session.getAttribute("usertype") != null) {
                %>
                <ul class="navbar-nav my-2 my-lg-0">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button"
                        data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> <%=session.getAttribute("name")%> </a>
                        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                            <a class="dropdown-item" href="<%=request.getContextPath()%>/user/changepassword.jsp">Change Password</a>
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item" href="<%=request.getContextPath()%>/Logout">Logout</a>
                        </div>
                    </li>
                </ul>
                <%
            	}
            %>
        </div>
    </div>
</nav>
