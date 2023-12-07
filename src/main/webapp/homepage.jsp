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
	String date = null;
	int rowPrimaryCount = 0;
	int rowSecondaryCount = 0;
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
		date = sesh.getAttribute("date").toString();

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
	<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
	<script src="homepageScripts.js"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>

<div class="container">
<%--	<h1>Welcome to your <%= config.getServletContext().getInitParameter("AppName") %> profile, <%= sessionName %></h1>--%>

	<div class="upper-container">
		<form action="NoteAddProcess" method="post">
			<input type="text" id="noteInput" style="text-align: center;" name="noteInput" placeholder="Insert New Note">
			<button id="submitNote" type="submit" class="submit-button">></button>
			<div>
				<input type="radio" name="boxSelector" value="divBox1" checked="checked"/>Primary
				<input type="radio" name="boxSelector" value="divBox2" />Secondary
			</div>
		</form>
		<button id="backwardDate" class="datebtn" onclick="changeDate('<%= date %>', -1)">-</button>
		<%= date %>
		<button id="forwardDate" class="datebtn" onclick="changeDate('<%= date %>', 1)">+</button>
		<i class="fa fa-calendar" onclick="openCalendarPopup('<%= date %>')"></i>

		<div class="calendar-popup" id="calendarPopup">
			<table>
				<!-- Calendar content goes here -->
			</table>
		</div>

	</div>

	<div class="scrollable-container">
		<div class="header-box">
			<p class="main-notes"> Primary Notes</p>
			<div class="scrollable-box" id="divBox1">
				<%
					try {
						String selectPrimaryNote = String.format("SELECT * FROM %s_primary_tab WHERE noteComplete = 0 AND noteDate = '%s';", sessionUsername, date);
						Class.forName("com.mysql.cj.jdbc.Driver");
						Connection conn = DriverManager.getConnection(DBConfig.getDbUrl(), DBConfig.getUsername(), DBConfig.getPassword());
						Statement stmt = conn.createStatement();
						ResultSet rs = stmt.executeQuery(selectPrimaryNote);

						while (rs.next()) {
							if (rs.getString("noteText") != null) {
								String noteCheck = rs.getString("noteComplete").toString();
								String check = "";
								if (noteCheck.equals("1")){
									check = "checked='checked'";
								}
								out.print("<form action='NoteDeleteProcess' method='post'>");
								out.print("<input type='hidden' name='notePrimaryText' value='" + rs.getString("noteText") + "'>");
								out.print("<div class='note-container'>");
								out.print("<input type='checkbox' class='noteCheck' id='note" + rowPrimaryCount + "' noteCheckType='primary'" + check + ">");
								out.print("<div class='note' id='note" + rowPrimaryCount + "' data-row-count='" + rowPrimaryCount + "'" + "' noteType=primary>" +
										"<div class='note-content'>" + rs.getString("noteText") + "</div></div>");
								out.print("<button type='submit'>X</button>");
								out.print("</div></form>");
								rowPrimaryCount++;
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
						String selectSecondaryNote = String.format("SELECT * FROM %s_secondary_tab WHERE noteComplete = 0 AND noteDate = '%s';", sessionUsername, date);
						Class.forName("com.mysql.cj.jdbc.Driver");
						Connection conn = DriverManager.getConnection(DBConfig.getDbUrl(), DBConfig.getUsername(), DBConfig.getPassword());
						Statement stmt = conn.createStatement();
						ResultSet rs = stmt.executeQuery(selectSecondaryNote);

						while (rs.next()) {
							if (rs.getString("noteText") != null) {
								String noteCheck = rs.getString("noteComplete").toString();
								String check = "";
								if (noteCheck.equals("1")){
									check = "checked='checked'";
								}
								out.print("<form action='NoteDeleteProcess' method='post'>");
								out.print("<input type='hidden' name='noteSecondaryText' value='" + rs.getString("noteText") + "'>");
								out.print("<div class='note-container'>");
								out.print("<input type='checkbox' class='noteCheck' id='note" + rowSecondaryCount + "' noteCheckType='secondary'" + check + ">");
								out.print("<div class='note' id='note" + rowSecondaryCount + "' data-row-count='" + rowSecondaryCount + "'" + "' noteType=secondary>" +
										"<div class='note-content'>" + rs.getString("noteText") + "</div></div>");
								out.print("<button type='submit'>X</button>");
								out.print("</div></form>");
								rowSecondaryCount++;
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
	<div class="dropdown-container">
		<div class="drop-down-completed" >
			<button onclick="primaryToggleDropdown()" class="dropbtn">View Completed</button>
		</div>
		<div class="drop-down-completed" >
			<button onclick="secondaryToggleDropdown()" class="dropbtn">View Completed</button>
		</div>
	</div>
	<div class="scrollable-container">
		<div class="header-box">
			<div class="scrollable-box" id="primary-dropdown-content" style="display:none">
				<%
					try {
						String selectSecondaryNote = String.format("SELECT * FROM %s_primary_tab WHERE noteComplete >= 1 AND noteDate = '%s';", sessionUsername, date);
						Class.forName("com.mysql.cj.jdbc.Driver");
						Connection conn = DriverManager.getConnection(DBConfig.getDbUrl(), DBConfig.getUsername(), DBConfig.getPassword());
						Statement stmt = conn.createStatement();
						ResultSet rs = stmt.executeQuery(selectSecondaryNote);

						while (rs.next()) {
							if (rs.getString("noteText") != null) {
								String noteCheck = rs.getString("noteComplete").toString();
								String check = "";
								String linethru = "";
								if (noteCheck.equals("1")){
									check = "checked='checked' style='text-decoration: line-through;'";
									linethru = "style='text-decoration: line-through;'";
								}
								out.print("<form action='NoteDeleteProcess' method='post'>");
								out.print("<input type='hidden' name='notePrimaryText' value='" + rs.getString("noteText") + "'>");
								out.print("<div class='note-container'>");
								out.print("<input type='checkbox' class='noteCheck' id='note" + rowPrimaryCount + "' noteCheckType='primary'" + check + ">");
								out.print("<div class='note' id='note" + rowPrimaryCount + "' data-row-count='" + rowPrimaryCount + "'" + "' noteType=primary>" +
										"<div class='note-content'" + linethru + ">" + rs.getString("noteText") + "</div></div>");
								out.print("<button type='submit'>X</button>");
								out.print("</div></form>");
								rowPrimaryCount++;
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
			<div class="scrollable-box" id="secondary-dropdown-content" style="display:none">
				<%
					try {
						String selectSecondaryNote = String.format("SELECT * FROM %s_secondary_tab WHERE noteComplete >= 1 AND noteDate = '%s';", sessionUsername, date);
						Class.forName("com.mysql.cj.jdbc.Driver");
						Connection conn = DriverManager.getConnection(DBConfig.getDbUrl(), DBConfig.getUsername(), DBConfig.getPassword());
						Statement stmt = conn.createStatement();
						ResultSet rs = stmt.executeQuery(selectSecondaryNote);

						while (rs.next()) {
							if (rs.getString("noteText") != null) {
								String noteCheck = rs.getString("noteComplete").toString();
								String check = "";
								String linethru = "";
								if (noteCheck.equals("1")){
									check = "checked='checked'";
									linethru = "style='text-decoration: line-through;'";
								}
								out.print("<form action='NoteDeleteProcess' method='post'>");
								out.print("<input type='hidden' name='noteSecondaryText' value='" + rs.getString("noteText") + "'>");
								out.print("<div class='note-container'>");
								out.print("<input type='checkbox' class='noteCheck' id='note" + rowSecondaryCount + "' noteCheckType='secondary'" + check + ">");
								out.print("<div class='note' id='note" + rowSecondaryCount + "' data-row-count='" + rowSecondaryCount + "'" + "' noteType=secondary>" +
										"<div class='note-content'" + linethru + ">" + rs.getString("noteText") + "</div></div>");
								out.print("<button type='submit'>X</button>");
								out.print("</div></form>");
								rowSecondaryCount++;
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
<div class="overlay" id="overlay"></div>

<%@ include file="WEB-INF/includes/footer.jsp" %>
</body>
</html>