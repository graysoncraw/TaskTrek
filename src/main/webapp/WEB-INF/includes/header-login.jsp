<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
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


        .logout-button {
            background-color: #f00; /* Red background color for the button */
            color: #fff; /* Text color for the button */
            padding: 5px 10px; /* Padding for the button */
            text-decoration: none; /* Remove underlines from the button text */
            border: none; /* Remove borders */
            border-radius: 5px; /* Rounded corners for the button */
            cursor: pointer;
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
    </header>
</body>
</html>
