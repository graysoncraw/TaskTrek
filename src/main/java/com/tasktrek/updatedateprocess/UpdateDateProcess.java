package com.tasktrek.updatedateprocess;
import com.tasktrek.dbconfig.DBConfig;

import java.io.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.*;
import java.sql.*;
import java.util.Date;

@WebServlet("/UpdateDateProcess")
public class UpdateDateProcess extends HttpServlet {
	private static final long serialVersionUID = 1L;


    public UpdateDateProcess() {
        // TODO Auto-generated constructor stub
    }

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		HttpSession session = req.getSession();
		String newDate = req.getParameter("newDate").toString();
		session.setAttribute("date", newDate);
		
	}
}
