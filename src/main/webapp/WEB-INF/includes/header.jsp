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

<%
    HttpSession sesh = request.getSession();
    String sessionUsername = sesh.getAttribute("username").toString();
%>

<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Audiowide">

    <style>
        @font-face {
            font-family: 'HyperSuperFast';
            src: url('/main/webapp/fonts/HyperSuperFast.ttf');
        }
        header {
            background-color: #373E40; /* Dark background color */
            color: #fff; /* Text color */
            padding: 10px; /* Padding for the header content */
            display: flex;
            justify-content: space-between; /* Align items to the start and end of the header */
            align-items: center;
        }

        .logo {
            font-size: 40px; /* Font size for the logo */
            font-weight: bold; /* Bold text */
            font-family: "Audiowide", sans-serif;
        }

        .logout-container {
            position: relative;
        }

        .logout-button {
            background-color: #f00; /* Red background color for the button */
            color: #fff; /* Text color for the button */
            padding: 5px 10px; /* Padding for the button */
            text-decoration: none; /* Remove underlines from the button text */
            border: none; /* Remove borders */
            border-radius: 5px; /* Rounded corners for the button */
            cursor: pointer;
        }

        .logout-dropdown {
            display: none;
            position: absolute;
            top: 100%;
            left: 0;
            background-color: #333;
            width:100%;
            box-shadow: 0 8px 16px rgba(0,0,0,0.2);
            z-index: 1;
            border-radius: 5px;
            text-align: center;
        }

        .logout-container:hover .logout-dropdown {
            display: block;
        }

        .logout-dropdown a {
            color: #fff;
            padding: 12px 16px;
            text-decoration: none;
            display: block;
        }

        .logout-dropdown a:hover {
            background-color: #555;
        }

        .logout-button:hover {
            background-color: #d00; /* Darker red on hover */
        }

        .reset-a, .reset-a:hover, .reset-a:visited, .reset-a:focus, .reset-a:active  {
            text-decoration: none;
            color: inherit;
            outline: 0;
            cursor: pointer;
        }
    </style>
</head>
<body>
<header>
    <div class="logo"><a class="reset-a" href="homepage">TaskTrek</a></div>
    <div class="logout-container">
            <button class="logout-button" type="submit">Welcome, <%= sessionName %></button>
        <form action='logout' method='post' id='logout-form'>
        <div class="logout-dropdown">
            <a href="#" onclick="submitForm()">Logout</a>
        </div>
        </form>
    </div>

    <script>
        function submitForm() {
            document.getElementById('logout-form').submit();
        }
    </script>
</header>
</body>
</html>
