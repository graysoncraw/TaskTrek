package com.tasktrek.signupprocess;

import com.tasktrek.dbconfig.DBConfig;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Servlet implementation class SignupProcess
 */
@WebServlet("/signupprocess")
public class SignupProcess extends HttpServlet {
	private static final long serialVersionUID = 1L;
	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public SignupProcess() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = req.getSession();
		PrintWriter out = res.getWriter();
		String name = req.getParameter("name");
		String email = req.getParameter("email");
		String username = req.getParameter("user");
		String password = req.getParameter("pass");
		RequestDispatcher rd;
		boolean insertion;
		boolean usernameAvailable;
		boolean emailAvailable;
		boolean passwordQualify;

		if (!isUsernameAvailable(username)) {
			String errorMessage = "Username is already in use";
			req.setAttribute("usernameError", errorMessage);
			req.getRequestDispatcher("/login").forward(req, res);
		}
		else if (!isEmailAvailable(email)) {
			String errorMessage = "Email is already in use";
			req.setAttribute("emailError", errorMessage);
			req.getRequestDispatcher("/login").forward(req, res);
		}
		else if (!doesPasswordQualify(password)) {
			String errorMessage = "Password does not qualify.<br>Must have an uppercase letter, a number, and a symbol.";
			req.setAttribute("passwordError", errorMessage);
			req.getRequestDispatcher("/login").forward(req, res);
		}

		else {
			if(insertUser(name, username, email, password)) {
				String tablePrimaryQuery = String.format("CREATE TABLE %s_primary_tab ( np_id INT AUTO_INCREMENT PRIMARY KEY, noteText TEXT, noteDate DATE, noteComplete BOOL);", username);
				String tableSecondaryQuery = String.format("CREATE TABLE %s_secondary_tab ( ns_id INT AUTO_INCREMENT PRIMARY KEY, noteText TEXT, noteDate DATE, noteComplete BOOL);", username);

				try {
					Class.forName("com.mysql.cj.jdbc.Driver");
					Connection conn = DriverManager.getConnection(DBConfig.getDbUrl(), DBConfig.getUsername(), DBConfig.getPassword());
					Statement stmt = conn.createStatement();
					stmt.executeUpdate(tablePrimaryQuery);
					stmt.executeUpdate(tableSecondaryQuery);
				} catch (SQLException e) {
					e.printStackTrace();
				} catch (ClassNotFoundException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

				Cookie sessionCookie = new Cookie("sessionId", session.getId());
				sessionCookie.setMaxAge(60 * 60 * 24 * 30); // Cookie expires in 30 days
				res.addCookie(sessionCookie);

				session.setAttribute("username", username);
				session.setAttribute("name", name);
				session.setAttribute("email", email);

				res.sendRedirect(req.getContextPath() + "/homepage");

			}
		}



	}

	private boolean isUsernameAvailable(String username) {
		String query = "SELECT * FROM users_tab WHERE username = '" + username + "';";
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conn = DriverManager.getConnection(DBConfig.getDbUrl(), DBConfig.getUsername(), DBConfig.getPassword());
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(query);
			return !rs.next();
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}

	private boolean isEmailAvailable(String email) {
		String query = "SELECT * FROM users_tab WHERE email = '" + email + "';";
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conn = DriverManager.getConnection(DBConfig.getDbUrl(), DBConfig.getUsername(), DBConfig.getPassword());
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(query);
			return !rs.next();
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}

	private boolean doesPasswordQualify(String password) {
		String pattern = "^(?=.*[A-Z])(?=.*\\d)(?=.*[@#$%^&+=!])(?!.*\\s).{8,}$";
		Pattern regex = Pattern.compile(pattern);
		Matcher matcher = regex.matcher(password);
		return matcher.matches();
	}

	// Helper method to insert a new user into the database

	private boolean insertUser(String name, String username, String email, String password) {
		String query = String.format("INSERT INTO users_tab (name, username, password, email) VALUES ('%s', '%s', '%s', '%s');", name, username, password, email);
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conn = DriverManager.getConnection(DBConfig.getDbUrl(), DBConfig.getUsername(), DBConfig.getPassword());
			Statement stmt = conn.createStatement();
			int rowsInserted = 0;
			if (name != "" && username != "" && email != "" && password != "") {
				rowsInserted = stmt.executeUpdate(query);
			}

			// Check if the insertion was successful
			if (rowsInserted > 0) {
				// The user was successfully inserted into the database
				return true;
			} else {
				// Insertion failed

				return false;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}

}
