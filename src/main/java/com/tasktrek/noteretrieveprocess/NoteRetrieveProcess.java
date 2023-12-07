package com.tasktrek.noteretrieveprocess;

import com.tasktrek.dbconfig.DBConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Date;
import java.io.PrintWriter;
import java.sql.*;

/**
 * Servlet implementation class NoteAddProcess
 */
@WebServlet("/NoteRetrieveProcess")
public class NoteRetrieveProcess extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public NoteRetrieveProcess() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession();
		String sessionUsername = session.getAttribute("username").toString();
		String date = session.getAttribute("date").toString();

		String retrievePrimaryChecked = String.format("SELECT * FROM %s_primary_tab WHERE noteComplete = 1 AND noteDate = %s", sessionUsername, date);
		String retrievePrimaryUnchecked = String.format("SELECT * FROM %s_primary_tab WHERE noteComplete = 0 AND noteDate = %s", sessionUsername, date);
		String retrieveSecondaryChecked = String.format("SELECT * FROM %s_secondary_tab WHERE noteComplete = 1 AND noteDate = %s", sessionUsername, date);
		String retrieveSecondaryUnchecked = String.format("SELECT * FROM %s_secondary_tab WHERE noteComplete = 0 AND noteDate = %s", sessionUsername, date);

		Connection conn;

		//PrintWriter out = response.getWriter();

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(DBConfig.getDbUrl(), DBConfig.getUsername(), DBConfig.getPassword());
			Statement stmt = conn.createStatement();

			ResultSet primaryChecked = stmt.executeQuery(retrievePrimaryChecked);
			ResultSet primaryUnchecked = stmt.executeQuery(retrievePrimaryUnchecked);
			ResultSet secondaryChecked = stmt.executeQuery(retrieveSecondaryChecked);
			ResultSet secondaryUnchecked = stmt.executeQuery(retrieveSecondaryUnchecked);




		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
//		// Retrieve the date parameter from the request
//		String dateString = request.getParameter("date");
//
//		// Parse the date string to a Date object using SimpleDateFormat
//		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
//		Date date = null;
//		try {
//			date = sdf.parse(dateString);
//		} catch (ParseException e) {
//			e.printStackTrace(); // Handle parsing exception appropriately
//		}
//
//		// Use the date to query the database and retrieve notes for that date
//		List<Note> notes = // Retrieve notes from the database based on the date
//
//				// Set the notes as a request attribute
//				request.setAttribute("notes", notes);
//
//		// Forward the request to a JSP fragment (notesFragment.jsp)
//		RequestDispatcher dispatcher = request.getRequestDispatcher("/notesFragment.jsp");
//		dispatcher.forward(request, response);
	}

}
