<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%! boolean correctlogin = true;

%>
<% if (session.getAttribute("username") != null) {
		response.sendRedirect("homepage.jsp");
	}
	else{
		request.setAttribute("loginPage", true);
%>
<html>
	<head>
  		<link rel="stylesheet" type="text/css" href="LoginStyles.css">
 		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
 		<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Alatsi">
 		<%@ include file="WEB-INF/includes/header-login.jsp" %>

	</head>
	
	<body>
	<div id="form">
		<div class="container">
		  <div class="col-lg-6 col-lg-offset-3 col-md-6 col-md-offset-3 col-md-8 col-md-offset-2">
			<div id="userform">
			  <ul class="nav nav-tabs nav-justified" role="tablist">
				<li class="active"><a href="#login"  role="tab" data-toggle="tab">Log in</a></li>
				<li><a href="#signup"  role="tab" data-toggle="tab">Sign up</a></li>
			  </ul>
			  <div class="tab-content">
				<div class="tab-pane fade active in" id="login">
					<h2 class="text-center"> Welcome Back!</h2>
					<form action="loginprocess" method="post">
						<div class="form-group">
						<input placeholder="Username" type="username" class="form-control" name="user" id="user" required data-validation-required-message="Please enter your username." autocomplete="off">
						<p class="help-block text-danger"></p>
					  </div>
					  <div class="form-group">
						<input placeholder="Password" type="password" class="form-control" name="pass" id="pass" required data-validation-required-message="Please enter your password" autocomplete="off">
						<p class="help-block text-danger"></p>
					  </div>
					  <div class="mrgn-30-top">
						<button type="submit" class="btn btn-larger btn-block">
						Login
						</button>
					  </div>
					  <div id="loginError" class="error-message">
					    <c:if test="${not empty request.loginError}">
					        <p class="text-danger">${request.loginError}</p>
					    </c:if>
					</div>
					</form>
				  </div>
				<div class="tab-pane fade in" id="signup">
				<form action="signupprocess" method="post">
					<h2 class="text-center"> Start Here!</h2>
					<div class="form-group">
						<input placeholder="Name" type="text" class="form-control" id="name" name="name" required data-validation-required-message="Please enter your name." autocomplete="off">
						<p class="help-block text-danger"></p>
					</div>
					<div class="form-group">
						<input placeholder="Username" type="user" class="form-control" id="user" name="user" required data-validation-required-message="Please enter your email address." autocomplete="off">
						<p class="help-block text-danger"></p>
					</div>
					<div class="form-group">
						<input placeholder="Email" type="email" class="form-control" id="email" name="email" required data-validation-required-message="Please enter your phone number." autocomplete="off">
						<p class="help-block text-danger"></p>
					</div>
					<div class="form-group">
						<input placeholder="Password" type="password" class="form-control" id="pass" name="pass" required data-validation-required-message="Please enter your password" autocomplete="off">
						<p class="help-block text-danger"></p>
					</div>
					<div class="mrgn-30-top">
						<button type="submit" class="btn btn-larger btn-block">
						Sign up
						</button>
					</div>
					<div id="signupError" class="error-message">
						<c:choose>
						    <c:when test="${not empty request.usernameError}">
						        <p class="text-danger">${request.usernameError}</p>
						    </c:when>
						    <c:when test="${not empty request.emailError}">
						        <p class="text-danger">${request.emailError}</p>
						    </c:when>
						    <c:when test="${not empty request.passwordError}">
						        <p class="text-danger">${request.passwordError}</p>
						    </c:when>
						</c:choose>
					</div>
					</form>
				</div>
			  </div>
			</div>
		  </div>
		</div>
		</div>
		<script src="//code.jquery.com/jquery-1.11.3.min.js"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
		<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

 		<%@ include file="WEB-INF/includes/footer.jsp" %>
 	</body>
 	<% } %>
</html>