package com.tasktrek.notedeleteprocess;

import com.tasktrek.dbconfig.DBConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

/**
 * Servlet implementation class NoteAddProcess
 */
@WebServlet("/NoteDeleteProcess")
public class NoteDeleteProcess extends HttpServlet {
    private static final long serialVersionUID = 1L;
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String notePrimaryText = request.getParameter("notePrimaryText");
        String noteSecondaryText = request.getParameter("noteSecondaryText");
        PrintWriter out = response.getWriter();
        out.println(notePrimaryText);

        try {
            Connection connection = DriverManager.getConnection(DBConfig.getDbUrl(), DBConfig.getUsername(), DBConfig.getPassword());

            HttpSession session = request.getSession();
            String sessionUsername = session.getAttribute("username").toString();
            out.println(sessionUsername);

            String deletePrimaryQuery = String.format("DELETE FROM %s_primary_tab WHERE noteText = '%s';", sessionUsername, notePrimaryText);
            String deleteSecondaryQuery = String.format("DELETE FROM %s_secondary_tab WHERE noteText = '%s';", sessionUsername, noteSecondaryText);
            out.println(deletePrimaryQuery);

            if (notePrimaryText != null) {
                Statement stmt = connection.createStatement();
                stmt.executeUpdate(deletePrimaryQuery);
                response.sendRedirect(request.getContextPath() + "/homepage");
            }
            else if (noteSecondaryText != null){
                Statement stmt = connection.createStatement();
                stmt.executeUpdate(deleteSecondaryQuery);
                response.sendRedirect(request.getContextPath() + "/homepage");
            }
            else{
                response.sendRedirect(request.getContextPath() + "/homepage");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
