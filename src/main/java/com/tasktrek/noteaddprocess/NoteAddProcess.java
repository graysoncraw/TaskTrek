package com.tasktrek.noteaddprocess;

import com.tasktrek.dbconfig.DBConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * Servlet implementation class NoteAddProcess
 */
@WebServlet("/NoteAddProcess")
public class NoteAddProcess extends HttpServlet {
	private static final long serialVersionUID = 1L; 
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public NoteAddProcess() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		String selectedBox = request.getParameter("boxSelector");
		String note = request.getParameter("noteInput");
		String sessionUsername = session.getAttribute("username").toString();
		String primaryQuery = String.format("INSERT INTO %s_notes_tab (primary_notes) VALUES ('%s');", sessionUsername, note);
		String secondaryQuery = String.format("INSERT INTO %s_notes_tab (secondary_notes) VALUES ('%s');", sessionUsername, note);
		Connection conn;
		
		PrintWriter out = response.getWriter();
		//out.print("on page");
		
		try {
            Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(DBConfig.getDbUrl(), DBConfig.getUsername(), DBConfig.getPassword());
			
	        Statement stmt = conn.createStatement();
	        

	        if("divBox1".equals(selectedBox) && note != "") {
		        stmt.executeUpdate(primaryQuery);
		        response.sendRedirect(request.getContextPath() + "/homepage");
				//out.print("divbox1 success");

	        }
	        else if("divBox2".equals(selectedBox) && note != ""){
		        stmt.executeUpdate(secondaryQuery);
		        response.sendRedirect(request.getContextPath() + "/homepage");
				//out.print("divbox2 success");

	        }
	        else {
		        response.sendRedirect(request.getContextPath() + "/homepage");
				//out.print("else hit");

	        }
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
	    } catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

}
