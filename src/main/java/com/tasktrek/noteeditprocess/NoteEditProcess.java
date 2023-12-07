package com.tasktrek.noteeditprocess;

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
@WebServlet("/NoteEditProcess")
public class NoteEditProcess extends HttpServlet {
    private static final long serialVersionUID = 1L;
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve parameters from the request
        int rowCount = Integer.parseInt(request.getParameter("rowCount"));
        String current = request.getParameter("current");
        String newcont = request.getParameter("newcont");
        String type = request.getParameter("type");


        // Retrieve sessions variables
        HttpSession session = request.getSession();
        String sessionUsername = session.getAttribute("username").toString();

        PrintWriter out = response.getWriter();
        out.println(type);

        try {
            Connection connection = DriverManager.getConnection(DBConfig.getDbUrl(), DBConfig.getUsername(), DBConfig.getPassword());
            out.println(sessionUsername);

            String editPrimaryNote = String.format("UPDATE %s_primary_tab SET noteText = '%s' WHERE noteText = '%s';", sessionUsername, newcont, current);
            String editSecondaryNote = String.format("UPDATE %s_secondary_tab SET noteText = '%s' WHERE noteText = '%s';", sessionUsername, newcont, current);
            out.println(editPrimaryNote);

            if (type.equals("primary")) {
                out.println("primary");
                Statement stmt = connection.createStatement();
                out.println("stmt");
                stmt.executeUpdate(editPrimaryNote);
                out.println("executed");
                //response.sendRedirect(request.getContextPath() + "/homepage");
            }
            else if (type.equals("secondary")){
                Statement stmt = connection.createStatement();
                stmt.executeUpdate(editSecondaryNote);
                //response.sendRedirect(request.getContextPath() + "/homepage");
            }
            else{
                //response.sendRedirect(request.getContextPath() + "/homepage");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
