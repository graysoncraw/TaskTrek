package com.tasktrek.notecompleteprocess;

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
@WebServlet("/NoteCompleteProcess")
public class NoteCompleteProcess extends HttpServlet {
    private static final long serialVersionUID = 1L;
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve parameters from the request
        String noteText = request.getParameter("noteText");
        String status = request.getParameter("status");
        String type = request.getParameter("type");

        // Retrieve sessions variables
        HttpSession session = request.getSession();
        String sessionUsername = session.getAttribute("username").toString();

        PrintWriter out = response.getWriter();
        out.println(noteText);
        out.println(status);

        try {
            Connection connection = DriverManager.getConnection(DBConfig.getDbUrl(), DBConfig.getUsername(), DBConfig.getPassword());
            out.println(sessionUsername);

            String completePrimaryNote = String.format("UPDATE %s_primary_tab SET noteComplete = 1 WHERE noteText = '%s';", sessionUsername, noteText);
            String incompletePrimaryNote = String.format("UPDATE %s_primary_tab SET noteComplete = 0 WHERE noteText = '%s';", sessionUsername, noteText);
            String completeSecondaryNote = String.format("UPDATE %s_secondary_tab SET noteComplete = 1 WHERE noteText = '%s';", sessionUsername, noteText);
            String incompleteSecondaryNote = String.format("UPDATE %s_secondary_tab SET noteComplete = 0 WHERE noteText = '%s';", sessionUsername, noteText);

            if (status.equals("checked")) {
                out.println("checked");
                if (type.equals("primary")){
                    Statement stmt = connection.createStatement();
                    stmt.executeUpdate(completePrimaryNote);
                    out.println("executePrimary");

                }
                else if (type.equals("secondary")){
                    Statement stmt = connection.createStatement();
                    stmt.executeUpdate(completeSecondaryNote);
                }
            }
            else if (status.equals("unchecked")){
                out.println("unchecked");
                if (type.equals("primary")){
                    Statement stmt = connection.createStatement();
                    stmt.executeUpdate(incompletePrimaryNote);
                    out.println("executePrimary");
                }
                else if (type.equals("secondary")){
                    Statement stmt = connection.createStatement();
                    stmt.executeUpdate(incompleteSecondaryNote);
                }
            }
            else{
                //response.sendRedirect(request.getContextPath() + "/homepage");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
