package com.tasktrek.login;
import com.tasktrek.dbconfig.DBConfig;

import java.io.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.*;
import java.sql.*;
import java.util.Date;

@WebServlet("/loginprocess")
public class loginprocess extends HttpServlet {
	private static final long serialVersionUID = 1L;


    public loginprocess() {
        // TODO Auto-generated constructor stub
    }

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		// TODO Auto-generated method stub
		PrintWriter out = res.getWriter();
		HttpSession session = req.getSession();
		String username = req.getParameter("user");
		String password = req.getParameter("pass");
		String query = "SELECT * FROM users_tab WHERE username = '" + username + "' AND password = '" + password + "';";
		boolean correctlogin;

		try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(DBConfig.getDbUrl(), DBConfig.getUsername(), DBConfig.getPassword());
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(query);
			RequestDispatcher rd;

			
			if(rs.next()) {
				Cookie sessionCookie = new Cookie("sessionId", session.getId());
				sessionCookie.setMaxAge(60 * 60 * 24 * 30); // Cookie expires in 30 days
				res.addCookie(sessionCookie);

				session.setAttribute("username", rs.getString("username"));
				session.setAttribute("name", rs.getString("name"));
				session.setAttribute("email", rs.getString("email"));
				session.setAttribute("date", new java.sql.Date(new Date().getTime()));
				
				res.sendRedirect(req.getContextPath() + "/homepage");
			}
			else {
			    String errorMessage = "Incorrect username or password";
				out.println("error");
			    req.setAttribute("loginError", errorMessage);
			    req.getRequestDispatcher("/login").forward(req, res);
		       
			}
			rs.close();
			stmt.close();
			conn.close();
		}
		catch(SQLException e){
			out.println("SQLException: " + e.getMessage());
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			out.println("exception2");
			e.printStackTrace();
		}
		
	}
}
