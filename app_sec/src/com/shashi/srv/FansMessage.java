package com.shashi.srv;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.owasp.html.HtmlPolicyBuilder;
import org.owasp.html.PolicyFactory;

@WebServlet("/fansMessage")
public class FansMessage extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String comments = request.getParameter("comments");

        // sanitizar dados
        name = sanitizeInput(name);
        email = sanitizeInput(email);
        comments = sanitizeInput(comments);

        if (isValidEmail(email)) {
            String htmlTextMessage = "<html><body>" +
                    "<h2 style='color:green;'>Message to Ellison Electronics</h2>" +
                    "Fans Message Received !!<br/><br/> Name: " + name + "," +
                    "<br/><br/> Email Id: " + email + "<br><br/>" +
                    "Comment: " + "<span style='color:grey;'>" + comments + "</span>" +
                    "<br/><br/>We are glad that fans are choosing us! <br/><br/>" +
                    "Thanks & Regards<br/><br/>Auto Generated Mail" +
                    "</body></html>";

            RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
            request.setAttribute("htmlTextMessage", htmlTextMessage);
            rd.include(request, response);
        } else {
            response.getWriter().print("<script>alert('Invalid input. Please check your data and try again.')</script>");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    private String sanitizeInput(String input) {
		PolicyFactory sanitizer = new HtmlPolicyBuilder().toFactory();
		String safeInpString = sanitizer.sanitize(input);
        return safeInpString;
    }

    private boolean isValidEmail(String email) {
		return email.contains("@");
    }
}
