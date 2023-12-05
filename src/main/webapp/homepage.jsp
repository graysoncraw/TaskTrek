<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.*"  %>
<%@ page import="java.io.*"  %>
<%@ page import="jakarta.servlet.http.*"  %>
<%@ page import="jakarta.servlet.annotation.WebServlet" %>
<%@ page import="com.tasktrek.dbconfig.DBConfig" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="jakarta.servlet.http.Cookie" %>

<!DOCTYPE html>

<%! String sessionName = null;
	String sessionUsername = null;
	int rowCount = 0;
%>

<%
	if (session.getAttribute("username") == null) {
		response.sendRedirect(request.getContextPath() + "/login");
	}
	else {
		request.setAttribute("loginPage", false);
		HttpSession sesh = request.getSession();
		sessionUsername = sesh.getAttribute("username").toString();
		sessionName = sesh.getAttribute("name").toString();
		String sessionEmail = sesh.getAttribute("email").toString();

		//String id = (String)req.getSession().getId();
		response.setContentType("text/html");
		PrintWriter outwriter = response.getWriter();

		Cookie[] cookies = request.getCookies();
	}

%>
<html>
<head>
	<meta charset="UTF-8">
	<title>TT - Homepage</title>
	<%@ include file="WEB-INF/includes/header.jsp" %>
	<link rel="stylesheet" type="text/css" href="HomepageStyles.css">


</head>
<body>

<div class="container">
	<h1>Welcome to your <%= config.getServletContext().getInitParameter("AppName") %> profile, <%= sessionName %></h1>

	<div class="input-container">
		<form action="NoteAddProcess" method="post">
			<input type="text" id="noteInput" name="noteInput" placeholder="Add a note">
			<select id="boxSelector" name="boxSelector">
				<option value="divBox1">Box 1</option>
				<option value="divBox2">Box 2</option>
			</select>
			<button id="submitNote" type="submit" class="submit-button">Submit</button>
		</form>
	</div>

	<div class="scrollable-container">
		<div class="header-box">
			<p class="main-notes"> Primary Notes</p>
			<div class="scrollable-box" id="divBox1">
				<%
					try {
						String selectPrimaryNote = String.format("SELECT * FROM %s_primary_tab;", sessionUsername);
						Class.forName("com.mysql.cj.jdbc.Driver");
						Connection conn = DriverManager.getConnection(DBConfig.getDbUrl(), DBConfig.getUsername(), DBConfig.getPassword());
						Statement stmt = conn.createStatement();
						ResultSet rs = stmt.executeQuery(selectPrimaryNote);

						while (rs.next()) {
							if (rs.getString("noteText") != null) {
								out.print("<form action='NoteDeleteProcess' method='post'>");
								out.print("<input type='hidden' name='notePrimaryText' value='" + rs.getString("noteText") + "'>");
								out.print("<div class='note' ondblclick='editNote(\"primaryNote" + rowCount + "\")'>" +
										rs.getString("noteText") +
										"<button type='submit'>X</button></div></form>");
								rowCount++;
							}
						}
					} catch (SQLException e) {
						e.printStackTrace();
					} catch (ClassNotFoundException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				%>
			</div>
		</div>
		<div class="header-box">
			<p class="opt-notes">Secondary Notes </p>

			<div class="scrollable-box" id="divBox2">
				<%
					try {
						String selectSecondaryNote = String.format("SELECT * FROM %s_secondary_tab;", sessionUsername);
						Class.forName("com.mysql.cj.jdbc.Driver");
						Connection conn = DriverManager.getConnection(DBConfig.getDbUrl(), DBConfig.getUsername(), DBConfig.getPassword());
						Statement stmt = conn.createStatement();
						ResultSet rs = stmt.executeQuery(selectSecondaryNote);

						while (rs.next()) {
							if (rs.getString("noteText") != null) {
								out.print("<form action='NoteDeleteProcess' method='post'>");
								out.print("<input type='hidden' name='noteSecondaryText' value='" + rs.getString("noteText") + "'>");
								out.print("<div class='note' ondblclick='editNote(\"secondaryNote" + rowCount + "\")'>" +
										rs.getString("noteText") +
										"<button type='submit'>X</button></div></form>");
								rowCount++;
							}
						}
					} catch (SQLException e) {
						e.printStackTrace();
					} catch (ClassNotFoundException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				%>
			</div>
		</div>
	</div>
</div>

<%@ include file="WEB-INF/includes/footer.jsp" %>
</body>
</html>