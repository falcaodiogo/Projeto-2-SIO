package com.shashi.srv;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.shashi.beans.UserBean;
import com.shashi.service.impl.UserServiceImpl;

import org.mindrot.jbcrypt.BCrypt;

import javax.crypto.SecretKey;

import com.shashi.utility.BreachedPasswords;
import com.shashi.utility.KeyManager;

/**
 * Servlet implementation class RegisterSrv
 */
@WebServlet("/RegisterSrv")
public class RegisterSrv extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private static SecretKey secretKey;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html");
		secretKey = KeyManager.getSecretKey();
		String userName = request.getParameter("username");
		String mobileNo = KeyManager.encrypt(request.getParameter("mobile"), secretKey);
		String emailId = request.getParameter("email");
		String address = KeyManager.encrypt(request.getParameter("address"), secretKey);
		String pinCode = KeyManager.encrypt(request.getParameter("pincode"), secretKey);
		String possibleSpacesPassword = request.getParameter("password");
		String possibleSpacesConfirmPassword = request.getParameter("confirmPassword");
		String consentCheckbox = request.getParameter("consentCheckbox");
		String status = "";
		String password = possibleSpacesPassword.trim().replaceAll(" +", " ");
		String confirmPassword = possibleSpacesConfirmPassword.trim().replaceAll(" +", " ");

		BreachedPasswords breachedPasswords = new BreachedPasswords();

		if (password != null && password.equals(confirmPassword)) {

			if (possibleSpacesPassword.length() >= 12 && possibleSpacesPassword.length() <= 128
					&& !possibleSpacesPassword.equals(possibleSpacesPassword.toLowerCase())
					&& possibleSpacesPassword.matches(".*\\d+.*")) {
				
				if (consentCheckbox == null || !consentCheckbox.equals("on")) {
					response.sendRedirect("register.jsp?message=Você deve concordar com os Termos e Condições.");
					return;
				  }

				if (password.length() >= 12) {

					if (breachedPasswords.isPasswordBreached(confirmPassword)) {
						status = "Your password is part of the 1000 more used. Please choose a different password.";
					} else {

						// Gere um salt aleatório
						String salt = BCrypt.gensalt();

						// Crie um hash da senha usando o salt
						String hashedPassword = BCrypt.hashpw(password, salt);

						System.out.println("Salt: " + salt);
						System.out.println("Password: " + password);
						System.out.println("Hashed Password: " + hashedPassword);

						UserBean user = new UserBean(userName, mobileNo, emailId, address, pinCode, hashedPassword,
								salt);

						UserServiceImpl dao = new UserServiceImpl();

						status = dao.registerUser(user);

					}

				} else {
					status = "Carefull with multiple spaces being truncated to only one!";
				}

			} else {
				status = "Must contain at least one number and one uppercase and lowercase letter, and between 12 and 128 characters!";
			}

		} else {
			status = "Password not matching!";
		}

		RequestDispatcher rd = request.getRequestDispatcher("register.jsp?message=" + status);

		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request, response);
	}

}
