<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.shashi.beans.ProductBean" %>
<%@ page import="com.shashi.beans.UserBean" %>
<%@ page import="com.shashi.service.impl.ProductServiceImpl" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.List" %>
<%@ page
	import="com.shashi.service.impl.*, com.shashi.service.*,com.shashi.beans.*,java.util.*,javax.servlet.ServletOutputStream,java.io.*"%>

    <!DOCTYPE html>
<html>
<head></head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
    href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<link rel="stylesheet" href="css/changes.css">
<script
    src="https://ajax.googleapis.com/libs/jquery/3.4.1/jquery.min.js"></script>
<script
    src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<body style="background-color: #ffffff;">
    <div class="container">
        <form>
            <fieldset>
                <legend>Comentários</legend>
                <div class="row">
                    <p>
                        <textarea class="form-control" id="comment" name="comment" rows="5"
                            <% if (userName == null) { %>
                                readonly
                                placeholder="Faça login para comentar"
                            <% } 
                            else{%>
                                placeholder="Comment"
                            <%}%>
                        ></textarea>

                    </p>
                    <p>
                        <input type="file" alt="Submit" id="fileinsertion" accept=".jpg, .jpeg, .png">
                    </p>
                    <p>
                        <input type="button" class="btn btn-success" value="Submit" onclick="saveComment('<%= userName %>')">
                    </p>
                </div>
            </fieldset>
            <div class="row">
                <div id="answer">
                </div>
            </div>
        </form>
        
    </div>
    
    <script>
        function saveComment(userName) {
            var comment = document.getElementById("comment").value;
            if (comment) {
                var prodID = '<%= productId %>';
                var key = prodID + "_comments";
                var fileInput = document.getElementById('fileinsertion');
                
                if (fileInput === null) {
                    // Não há arquivo de imagem, apenas salvar o comentário
                    var existingComments = JSON.parse(localStorage.getItem(key)) || [];
                    existingComments.push({ userName: userName, comment: comment });
                    localStorage.setItem(key, JSON.stringify(existingComments));
                    displayComments(prodID);
                } else {
                    // Há um arquivo de imagem
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        var imageBase64 = e.target.result; // A imagem em formato base64
                        var existingComments = JSON.parse(localStorage.getItem(key)) || [];
                        existingComments.push({ userName: userName, comment: comment, image: imageBase64 });
                        localStorage.setItem(key, JSON.stringify(existingComments));
                        displayComments(prodID);
                    };
                    
                    reader.readAsDataURL(fileInput.files[0]);
                }
            }
            if(fileInput){
                var reader = new FileReader();
                    reader.onload = function (e) {
                        var imageBase64 = e.target.result; // A imagem em formato base64
                        var existingComments = JSON.parse(localStorage.getItem(key)) || [];
                        existingComments.push({ userName: userName, comment: comment, image: imageBase64 });
                        localStorage.setItem(key, JSON.stringify(existingComments));
                        displayComments(prodID);
                    };
                    
                    reader.readAsDataURL(fileInput.files[0]);
            }
        }

        function displayComments(prodID) {
            var answerDiv = document.getElementById("answer");
            answerDiv.style.marginTop = "20px";

            var key = prodID + "_comments";
            var existingComments = JSON.parse(localStorage.getItem(key)) || [];
            answerDiv.innerHTML = '';

            existingComments.forEach(function (entry) {
                var usernameDiv = document.createElement("div");
                usernameDiv.style.fontWeight = "bold";
                usernameDiv.style.marginTop = "20px";
                usernameDiv.textContent = entry.userName;
                answerDiv.appendChild(usernameDiv);

                if (entry.image !== null && entry.comment===undefined) {
                    var image = document.createElement("img");
                    image.src = entry.image; 
                    answerDiv.appendChild(image);
                    return;
                    
                }

                var commentDiv = document.createElement("div");
                commentDiv.style.padding = "10px";
                commentDiv.style.marginTop = "5px";
                commentDiv.style.border = "0.1px solid #ccc";
                commentDiv.style.borderRadius = "5px";
                commentDiv.style.height = "auto";
                commentDiv.style.overflow = "auto";
                commentDiv.style.marginBottom = "20px";
                commentDiv.textContent = entry.comment;
                answerDiv.appendChild(commentDiv);

                if (entry.image !== null) {
                    var image = document.createElement("img");
                    image.src = entry.image; 
                    answerDiv.appendChild(image);
                    return;
                    
                }

            });
        }



        displayComments('<%= userName %>', '<%= productId %>');
    </script>
    <script>
        // ...
        
        // Adicione este código para chamar displayComments quando a página for carregada
        document.addEventListener("DOMContentLoaded", function() {
            var prodID = '<%= productId %>'; // Obtém o ID do produto
            displayComments(prodID);
        });
    </script>

</body>
</html>
