package com.shashi.srv;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.mindrot.jbcrypt.BCrypt;

import com.shashi.beans.UserBean;
import com.shashi.service.impl.UserServiceImpl;
import com.shashi.utility.BreachedPasswords;

/**
 * Servlet implementation class LoginSrv
 */
@WebServlet("/ChangePassword")
public class ChangePassword extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public ChangePassword() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        String userName = request.getParameter("username");
        String oldPassword = request.getParameter("oldPassword");
        String newPassword = request.getParameter("newPassword");
        response.setContentType("text/html");

        String status;

        BreachedPasswords breachedPasswords = new BreachedPasswords();

        UserServiceImpl udao = new UserServiceImpl();

        status = udao.isValidCredential(userName, oldPassword);

        if (status.equalsIgnoreCase("valid")) {
            // valid user

            if (breachedPasswords.isPasswordBreached(newPassword)) {

                if (newPassword.length() < 12) {
                    status = "password too small!";
                } else {

                    UserBean user = udao.getUserDetails(userName, oldPassword);

                    String salt = BCrypt.gensalt();
                    String hashedPassword = BCrypt.hashpw(newPassword, salt);

                    System.out.println("Salt: " + salt);
                    System.out.println("Password: " + newPassword);
                    System.out.println("Hashed Password: " + hashedPassword);

                    UserBean user2 = new UserBean(user.getName(), user.getMobile(), user.getEmail(), user.getAddress(),
                            user.getPinCode(), hashedPassword, salt);

                    UserServiceImpl dao = new UserServiceImpl();

                    udao.removeUser(user);

                    status = dao.registerUser(user2);

                    HttpSession session = request.getSession();

                    session.setAttribute("username", userName);
                    session.setAttribute("password", newPassword);
                    session.setAttribute("usertype", "customer");
                }

            } else {
                status = "Your password is part of the 1000 more used. Please choose a different password.";
            }

        } else {
            // invalid user

            status = "Incorrect username or password";

        }

        RequestDispatcher rd = request.getRequestDispatcher("login.jsp?message=" + status);

        rd.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        doGet(request, response);
    }

}
