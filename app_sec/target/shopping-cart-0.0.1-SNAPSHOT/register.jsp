<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
  <head>
    <title>Register</title>
    <link
      rel="stylesheet"
      href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css"
    />
    <link rel="stylesheet" href="css/changes.css" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
    <script src="js/zxcvbn.js"></script>
    <script>
      $(document).ready(function () {
        $('#password').on('input', function () {
          var password = $(this).val();
          var result = zxcvbn(password);

          // Exiba a pontuação de força (opcional)
          console.log('Pontuação de força da senha:', result.score);

          // Atualize o texto e a cor da barra de força de senha
          updatePasswordStrength(result.score);
        });

        function updatePasswordStrength(score) {
          var meterContainer = $('#password-strength-meter');
          var meterBar = meterContainer.find('.password-strength-bar');
          var meterText = meterContainer.find('.password-strength-text');

          meterBar.width(score * 25 + '%'); // Ajusta a largura com base na pontuação (0% - 100%)
          meterText.text(getMeterText(score)); // Atualiza o texto da força da senha
          meterContainer.removeClass().addClass(getMeterClass(score)); // Atualiza a cor da barra
        }

        function getMeterText(score) {
          switch (score) {
            case 0:
            case 1:
              return 'Weak';
            case 2:
              return 'Fair';
            case 3:
              return 'Good';
            case 4:
              return 'Strong';
            default:
              return '';
          }
        }

        function getMeterClass(score) {
          switch (score) {
            case 0:
            case 1:
              return 'weak';
            case 2:
              return 'fair';
            case 3:
              return 'good';
            case 4:
              return 'strong';
            default:
              return '';
          }
        }
      });
    </script>

    <style>
      .password-strength-meter {
        height: 10px;
        margin-top: 5px;
        width: 100%; /* Certifique-se de que o medidor ocupa toda a largura do contêiner pai */
        display: block; /* Certifique-se de que o medidor é exibido como bloco */
        border-radius: 5px; /* Borda arredondada */
        overflow: hidden; /* Para ocultar bordas arredondadas em algumas situações */
      }

      .password-strength-bar {
        height: 100%;
        transition: width 0.3s ease; /* Adiciona uma transição suave para a largura */
      }

      .password-strength-text {
        font-size: 12px;
        margin-left: 5px;
        font-weight: bold;
      }

      .weak {
        background-color: #ff5555; /* Vermelho para senha fraca */
      }

      .fair {
        background-color: #ffa500; /* Laranja para senha razoável */
      }

      .good {
        background-color: #ffd700; /* Amarelo para senha boa */
      }

      .strong {
        background-color: #00ff00; /* Verde para senha forte */
      }
    </style>
  </head>
  <body style="background-color: #ffffff">
    <%@ include file="header.jsp"%> <% String message =
    request.getParameter("message"); %>
    <div class="container">
      <div
        class="row"
        style="margin-top: 5px; margin-left: 2px; margin-right: 2px"
      >
        <form
          action="./RegisterSrv"
          method="post"
          class="col-md-6 col-md-offset-3"
          style="
            border: 2px solid black;
            border-radius: 10px;
            background-color: #ffffff;
            padding: 10px;
          "
        >
          <div style="font-weight: bold" class="text-center">
            <h2 style="color: green">Registration Form</h2>
            <% if (message != null) { %>
            <p style="color: blue"><%=message%></p>
            <% } %>
          </div>
          <div></div>
          <div class="row">
            <div class="col-md-6 form-group">
              <label for="first_name">Name</label>
              <input
                type="text"
                name="username"
                class="form-control"
                id="first_name"
                name="first_name"
                required
              />
            </div>
            <div class="col-md-6 form-group">
              <label for="last_name">Email</label>
              <input
                type="email"
                name="email"
                class="form-control"
                id="last_name"
                name="last_name"
                required
              />
            </div>
          </div>
          <div class="form-group">
            <label for="last_name">Address</label>
            <textarea
              name="address"
              class="form-control"
              id="last_name"
              name="last_name"
              required
            ></textarea>
          </div>
          <div class="row">
            <div class="col-md-6 form-group">
              <label for="last_name">Mobile</label>
              <input
                name="mobile"
                class="form-control"
                id="last_name"
                name="last_name"
                required
              />
            </div>
            <div class="col-md-6 form-group">
              <label for="last_name">Pin Code</label>
              <input
                name="pincode"
                class="form-control"
                id="last_name"
                name="last_name"
                required
              />
            </div>
          </div>
          <div class="row">
            <div class="col-md-6 form-group">
              <label for="password">Strong Password</label>
              <input
                type="password"
                name="password"
                class="form-control"
                id="password"
                name="last_name"
                title="Incorrect text"
                required
              />
              <div id="password-strength-meter" class="password-strength-meter">
                <div class="password-strength-text">Strength</div>
                <div class="password-strength-bar"></div>
              </div>
            </div>

            
            


            <div class="col-md-6 form-group">
              <label for="confirmPassword">Confirm Strong Password</label>
              <input
                type="password"
                name="confirmPassword"
                class="form-control"
                id="confirmPassword"
                name="last_name"
                title="Incorrect text"
                required
              />
            </div>
          </div>
          <div class="row text-center">
            <div class="col-md-6" style="margin-bottom: 2px">
              <button type="Reset" class="btn btn-danger">Reset</button>
            </div>
            <div class="col-md-6">
              <button type="submit" class="btn btn-success">Register</button>
            </div>
          </div>
          <div class="row">
            <div class="col-md-12 form-group">
              <div class="checkbox">
                <label>
                  <input type="checkbox" id="consentCheckbox" name="consentCheckbox" required>
                  Eu concordo com o uso dos meus dados pessoais de acordo com os termos e condicoes.
                </label>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-md-12 form-group">
              <a href="#" data-toggle="modal" data-target="#termsModal">Termos e Condicoes</a>
            </div>
          </div>
        </form>
      </div>
    </div>

    <div id="termsModal" class="modal fade" role="dialog">
      <div class="modal-dialog">
        <!-- Conteúdo do modal -->
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title">Termos e Condicoes</h4>
          </div>
          <div class="modal-body">
            <p>Terms and Conditions
              1. Introduction
              Welcome to our online deti shop! These terms and conditions govern your use of our website and services offered. By accessing or using our website, you agree to comply with these terms and conditions. Please read them carefully.
              
              2. Access and Account Creation
              2.1. Our website allows the purchase of products either by adding them to the cart or by immediate purchase.
              
              2.2. The cart functionality permits modification of product quantities (adding or removing products).
              
              2.3. Account creation is available with the option to log in as an administrator or customer based on the account type.
              
              3. Product Comments and Search
              3.1. Users can post comments on each product page, including images, text, or both.
              
              3.2. The website facilitates product search using the search bar and filters available in the Category section.
              
              4. Technologies Used
              4.1. The website is built using the following technologies:
              
              Front-End: HTML, CSS, JavaScript, and Bootstrap.
              Back-End: Java (JDK8+), JDBC (Java Database Connectivity), Servlet, and JSP (Jakarta Server Pages).
              Database: MySQL.
              Additional Tools: TomCat, Maven, docker-compose for efficient page loading.
              5. Disclaimer
              5.1. The vulnerabilities used for the development of this website were sourced from a repository authored by Shashi Rash.
              
              5.2. While we strive to provide a secure platform, we do not guarantee absolute security. Users are responsible for their actions and data security.
              
              6. Acceptable Use
              6.1. Users must not misuse the website, violate laws, or infringe on others' rights.
              
              6.2. Users must not attempt unauthorized access, interfere with the website's functionality, or distribute harmful content.
              
              7. Limitation of Liability
              7.1. We are not liable for any direct, indirect, or incidental damages resulting from the use of our website, including but not limited to loss of data, profits, or business interruption.
              
              8. Modifications to Terms
              8.1. We reserve the right to modify these terms and conditions at any time without prior notice. Continued use of the website constitutes acceptance of the modified terms.
              
              9. Governing Law
              9.1. These terms and conditions are governed by [Jurisdiction]'s laws, and any disputes shall be resolved in accordance with these laws.
              
              10. Contact Information
              10.1. For any queries or concerns regarding these terms, please contact us at [Contact Information].
              
              By using our website, you agree to abide by these terms and conditions. If you do not agree with any part of these terms, please refrain from using our website.
              
              Thank you for choosing our deti shop!</p>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">Fechar</button>
          </div>
        </div>
      </div>
    </div>
    
    <%@ include file="footer.html"%>
  </body>
</html>
