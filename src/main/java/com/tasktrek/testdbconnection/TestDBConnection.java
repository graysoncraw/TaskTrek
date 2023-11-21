package com.tasktrek.testdbconnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

/**
 * Servlet implementation class TestDBConnection
 */
@WebServlet(name = "testdbconnection", value = "/testdbconnection")
public class TestDBConnection extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TestDBConnection() {
        super();
        // TODO Auto-generated constructor stub
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter out = response.getWriter();

        final String DB_URL = "jdbc:mysql://localhost:3306/tasktrek_db";
        final String USER = "root";
        final String PASS = "hsjmieemkgie612";
		String query = "SELECT * FROM users_tab WHERE username = ? AND password = ?;";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setString(1, "urdjdru");
            pstmt.setString(2, "dru1");
            ResultSet rs = pstmt.executeQuery();
            rs.next();
            out.println("Database connection successful.");
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
            out.println("Database connection failed.");
        } catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }

}
