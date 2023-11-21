package com.tasktrek.logout;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/logout")
public class logout extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public logout() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		HttpSession session = req.getSession(false); // Do not create a new session if it doesn't exist
		if (session != null) {
		    session.invalidate(); // Invalidate the session
		}

		// Remove session cookie
		Cookie[] cookies = req.getCookies();
		if (cookies != null) {
		    for (Cookie cookie : cookies) {
	            cookie.setMaxAge(0); // Delete the cookie
	            res.addCookie(cookie);
	            break;
		        
		    }
		}

		res.sendRedirect(req.getContextPath() + "/login"); // Redirect to the login page
		
	}

}
