package controller;

import java.io.IOException;

import java.sql.Connection;

import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import util.ConnectionProvider;



/**
 * Servlet implementation class CategoryAdd
 */
public class CategoryAdd extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public CategoryAdd() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try{  
			Connection con=ConnectionProvider.getConnection() ;  
			PreparedStatement ps=con.prepareStatement("select nvl(max(id),0) from categories");

			ResultSet rs=ps.executeQuery();
			int max=0;
			if(rs.next())
			{
				max=rs.getInt(1);
				max++;
			}

			ps=con.prepareStatement("Insert into categories values(?,?,?,?)");
			ps.setInt(1, max);
			ps.setString(2, request.getParameter("dept_id"));
			ps.setString(3, request.getParameter("name"));
			ps.setString(4, request.getParameter("priority"));

			ps.executeUpdate();

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		HttpSession session = request.getSession();
		session.setAttribute("msg", "Category added successfully.");
		session.setAttribute("class", "alert-success");
		response.sendRedirect(request.getContextPath() + "/admin/category/add.jsp");
	}

}

