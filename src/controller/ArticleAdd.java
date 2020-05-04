package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import util.ConnectionProvider;

public class ArticleAdd extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public ArticleAdd() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
			Connection con = ConnectionProvider.getConnection();
			PreparedStatement ps=con.prepareStatement("select nvl(max(id),0) from articles");
			
			ResultSet rs=ps.executeQuery();
			int max=0;
			if(rs.next())
			{
				max=rs.getInt(1);
				max++;
			}
			
			ps=con.prepareStatement("Insert into articles values(?,?,?,?,sysdate)");
			ps.setInt(1, max);
			ps.setString(2, request.getParameter("title"));
			ps.setString(3, request.getParameter("content"));
			
			HttpSession session = request.getSession();
			int user_id = (int) session.getAttribute("id");
			
			ps.setInt(4, user_id);
			
			ps.executeUpdate();
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		HttpSession session = request.getSession();
		session.setAttribute("msg", "Article added successfully.");
		session.setAttribute("class", "alert-success");
		response.sendRedirect(request.getContextPath() + "/admin/article/add.jsp");
	}

}
