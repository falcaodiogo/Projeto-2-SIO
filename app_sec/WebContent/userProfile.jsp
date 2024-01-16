<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1"%> <%@ page import="com.shashi.service.impl.*,
com.shashi.service.*,com.shashi.beans.*,
java.util.*,javax.servlet.ServletOutputStream,java.io.*"%><%@ page
import="java.sql.Connection, java.sql.PreparedStatement, java.sql.SQLException"
%> <%@ page import="java.sql.Connection, java.sql.PreparedStatement,
java.sql.SQLException" %> <%@ page import="com.shashi.service.UserService,
com.shashi.beans.UserBean" %>
<!DOCTYPE html>
<html>
  <head>
    <title>Profile Details</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link
      rel="stylesheet"
      href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css"
    />
    <link rel="stylesheet" href="css/changes.css" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"
    />
  </head>
  <body style="background-color: #ffffff">
    <% /* Checking the user credentials */ String userName = (String)
    session.getAttribute("username"); String password = (String)
    session.getAttribute("password"); if (userName == null || password == null)
    { response.sendRedirect("login.jsp?message=Session Expired, Login Again!!");
    } UserServiceImpl udao = new UserServiceImpl(); UserBean user =
    udao.getUserDetails(userName, password); String message =
    request.getParameter("message"); %>

    <jsp:include page="header.jsp" />

	<div class="container bg-secondary">
		<div class="row">
			<div class="col">
				<nav aria-label="breadcrumb" class="bg-light rounded-3 p-3 mb-4">
					<ol class="breadcrumb mb-0">
						<li class="breadcrumb-item"><a href="index.jsp">Home</a></li>
						<li class="breadcrumb-item"><a href="profile.jsp">User
								Profile</a></li>
					</ol>
				</nav>
			</div>
		</div>

		<div class="row">
			<div class="col-lg-4">
				<div class="card mb-4">
					<div class="card-body text-center">
						<img src="images/profile.jpg" class="rounded-circle img-fluid"
							style="width: 150px;">
						<h5 class="my-3">
							Hello
							<%=user.getName()%>
							here!!
						</h5>
						<!-- <p class="text-muted mb-1">Full Stack Developer</p>
						<p class="text-muted mb-4">Bay Area, San Francisco, CA</p> -->
						<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#passwordChangeModal">
							Change Password
						</button>
						<br>
					</div>
					<br>
				</div>
				<div class="card mb-4 mb-lg-0">
					<div class="card-body p-0">
						<ul class="list-group list-group-flush rounded-3">

							<li
								class="text-center list-group-item d-flex justify-content-between align-items-center p-3">
								<h1>My Profile</h1>
							</li>
						</ul>
					</div>
				</div>
			</div>
			<div class="col-lg-8">
				<div class="card mb-4">
					<div class="card-body">
						<div class="row">
							<div class="col-sm-3">
								<p class="mb-0">Full Name</p>
							</div>
							<div class="col-sm-9">
								<p class="text-muted mb-0"><%=user.getName()%></p>
							</div>
						</div>
						<hr>
						<div class="row">
							<div class="col-sm-3">
								<p class="mb-0">Email</p>
							</div>
							<div class="col-sm-9">
								<p class="text-muted mb-0"><%=user.getEmail()%>
								</p>
							</div>
						</div>
						<hr>
						<div class="row">
							<div class="col-sm-3">
								<p class="mb-0">Phone</p>
							</div>
							<div class="col-sm-9">
								<p class="text-muted mb-0"><%=user.getMobile()%>
								</p>
							</div>
						</div>
						<hr>
						<div class="row">
							<div class="col-sm-3">
								<p class="mb-0">Address</p>
							</div>
							<div class="col-sm-9">
								<p class="text-muted mb-0"><%=user.getAddress()%>
								</p>
							</div>
						</div>
						<hr>
						<div class="row">
							<div class="col-sm-3">
								<p class="mb-0">PinCode</p>
							</div>
							<div class="col-sm-9">
								<p class="text-muted mb-0"><%=user.getPinCode()%>
								</p>
							</div>
						</div>
					</div>
				</div>
			</div>

			<div class="modal fade" id="passwordChangeModal" tabindex="-1" role="dialog" aria-labelledby="passwordChangeModalLabel" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="passwordChangeModalLabel">Change Password</h5>
							<button type="button" class="close" data-dismiss="modal" aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>
						<div class="modal-body">
							<form method="post">
								<div class="form-group">
									<label for="oldPassword">Old Password</label>
									<input type="password" class="form-control" id="oldPassword" name="oldPassword" required>
								</div>
								<div class="form-group">
									<label for="newPassword">New Password</label>
									<input type="password" class="form-control" id="newPassword" name="newPassword" required>
								</div>
								<div class="form-group">
									<label for="confirmPassword">Confirm New Password</label>
									<input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
								</div>
								<button type="submit" class="btn btn-primary">Change Password</button>
								<%
								UserService dao1 = new UserServiceImpl();
								%>
								<%
								dao1.updateUser(user); // Call the updateUser method with the user parameter.
								%>
							</form>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
						</div>
						
						
					</div>
				</div>
			</div>
			<button type="button" class="btn btn-danger" data-toggle="modal" data-target="#deleteAccountModal">
				Delete Account
			</button>
			<div class="modal fade" id="deleteAccountModal" tabindex="-1" role="dialog" aria-labelledby="deleteAccountModalLabel" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="deleteAccountModalLabel">Confirm Account Deletion</h5>
							<button type="button" class="close" data-dismiss="modal" aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>
						<div class="modal-body">
							<p>Are you sure you want to delete your account? This action cannot be undone.</p>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
							<button type="button" class="btn btn-danger" onclick="confirmDeleteAccount()">Delete Account</button>
						</div>
					</div>
				</div>
			</div>

		</div>
	</div>

	<br>
	<br>
	<br>

	<%@ include file="footer.html"%>
	<script>
		function confirmDeleteAccount() {
			// Chama uma função no backend para excluir a conta
			$.ajax({
				url: 'DeleteAccountServlet', // Substitua 'DeleteAccountServlet' pelo URL do seu servlet ou ação de exclusão de conta
				type: 'POST',
				success: function(response) {
					// Redireciona para a página de login após a exclusão da conta
					window.location.href = 'login.jsp';
				},
				error: function(error) {
					// Lidar com erros, se necessário
					console.error('Error deleting account:', error);
				}
			});
		}
	</script>

    <%@ include file="footer.html"%>
  </body>
</html>
