<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
 	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Alatsi">
    <meta charset="UTF-8">
    <style>
        /* Basic CSS styles for the footer */
        body {
            margin: 0; /* Remove default margin */
            padding: 0; /* Remove default padding */
            display: flex;
            flex-direction: column;
            min-height: 100vh; /* Ensure the body takes at least the full viewport height */
            font-family: Alatsi, sans-serif;
        }

        /* Main content wrapper (excluding footer) */
        .content {
            background-color: #636f7f;
            flex-grow: 1; /* Allow content to grow to fill available space */
            padding: 20px; /* Padding for the content area */
        }

        footer {
            background-color: #373E40; /* Dark background color */
            color: #fff; /* Text color */
            padding: 10px; /* Padding for the footer content */
            text-align: center; /* Center-align text in the footer */
        }

        /* Style for the footer links */
        .footer-link {
            color: #fff; /* Text color for links */
            text-decoration: none; /* Remove underlines from links */
            margin: 0 10px; /* Add spacing between links */
        }

        .footer-link:hover {
            text-decoration: underline; /* Underline links on hover */
        }
    </style>
</head>
<body>
    <div class="content">
        <!-- Your page content goes here -->
    </div>
    <footer>
        <div>
            <a href="#" class="footer-link">Privacy Policy</a>
            <a href="#" class="footer-link">Terms of Service</a>
            <a href="#" class="footer-link">Contact Us</a>
        </div>
        <div>&copy; 2023 TaskTrek</div>
    </footer>
</body>
</html>
