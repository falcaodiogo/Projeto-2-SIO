package com.shashi.srv;

import java.io.IOException;
import java.security.KeyManagementException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
// import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.shashi.beans.UserBean;
import com.shashi.service.UserService;
import com.shashi.service.impl.UserServiceImpl;

import org.mindrot.jbcrypt.BCrypt;


@WebServlet("/DeleteAccountServlet")
public class DeleteAccountServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtém as informações do usuário da sessão
        HttpSession session = request.getSession();
        String userName = (String) session.getAttribute("username");

        // Chame a lógica do serviço para excluir a conta do banco de dados
        UserService userService = new UserServiceImpl();
        userService.deleteUser(userName);

        // Limpe os atributos da sessão
        session.setAttribute("username", null);
		session.setAttribute("password", null);
		session.setAttribute("usertype", null);
		session.setAttribute("userdata", null);
        // Adicione mais atributos da sessão que você deseja limpar

        response.getWriter().write("Account deleted successfully");
    }
}