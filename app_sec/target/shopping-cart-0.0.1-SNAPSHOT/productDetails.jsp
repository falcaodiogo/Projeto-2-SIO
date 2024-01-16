<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.shashi.beans.ProductBean" %>
<%@ page import="com.shashi.service.impl.ProductServiceImpl" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.List" %>
<%@ page
	import="com.shashi.service.impl.*, com.shashi.service.*,com.shashi.beans.*,java.util.*,javax.servlet.ServletOutputStream,java.io.*"%>

<!DOCTYPE html>
<html>
<head>
    <title>Product Details</title>
</head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<link rel="stylesheet" href="css/changes.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<body style="background-color: #ffffff;">
    <%
    String productId = request.getParameter("pid");

    String userName = (String) session.getAttribute("username");
	String password = (String) session.getAttribute("password");
	String userType = (String) session.getAttribute("usertype");

	boolean isValidUser = true;

	if (userType == null || userName == null || password == null || !userType.equals("customer")) {

		isValidUser = false;
	}

    ProductBean product = null; 

    ProductServiceImpl prodDao = new ProductServiceImpl();
    List<ProductBean> products = prodDao.getAllProducts();

    String search = request.getParameter("search");
    String type = request.getParameter("type");
    String message = "All Products";
    if (search != null) {
      products = prodDao.searchAllProducts(search);
      message = "Showing Results for '" + search + "'";
    } else if (type != null) {
      products = prodDao.getAllProductsByType(type);
      message = "Showing Results for '" + type + "'";
    } else {
      products = prodDao.getAllProducts();
    }
    if (products.isEmpty()) {
      message = "No items found for the search '" + (search != null ? search : type) + "'";
      products = prodDao.getAllProducts();
    }
    
    Map<String, ProductBean> productMap = new HashMap<>();
    for (ProductBean p : products) {
        productMap.put(p.getProdId(), p);
    }
    
    if (productMap.containsKey(productId)) {
        product = productMap.get(productId);
    }
    %>

    <jsp:include page="header.jsp" />

    <br>
    <br>
    <br>
    <br>
    <div class="container">
      <div class="row">

        <%
        int cartQty = new CartServiceImpl().getCartItemCount(userName, product.getProdId());
        %>

        <div class="col-sm-4" style="height: 350px;">
          <img src="./ShowImage?pid=<%=productId%>" style="height: 150px; max-width: 180px">
        </div>

        <div class="col-sm-8" style="border: 1px solid #ddd; line-height: 1; border-radius: 20px; padding: 30px;">
          <p class="productname"><%=product.getProdName()%></p>
          <br>
          <p class="price">
						<%=product.getProdPrice()%>
					</p>
          <br>
          <%
          String description = product.getProdInfo();
          %>
          <p class="productinfo"><%=description%></p>

          <br>
          <br>

          <form method="post">
            <%
            if (cartQty == 0) {
            %>
            <button type="submit"
              formaction="./AddtoCart?uid=<%=userName%>&pid=<%=product.getProdId()%>&pqty=1"
              class="btn btn-success">Add to Cart</button>
            &nbsp;&nbsp;&nbsp;
            <button type="submit"
              formaction="./AddtoCart?uid=<%=userName%>&pid=<%=product.getProdId()%>&pqty=1"
              class="btn btn-primary">Buy Now</button>
            <%
            } else {
            %>
            <button type="submit"
              formaction="./AddtoCart?uid=<%=userName%>&pid=<%=product.getProdId()%>&pqty=0"
              class="btn btn-danger">Remove From Cart</button>
            &nbsp;&nbsp;&nbsp;
            <button type="submit" formaction="cartDetails.jsp"
              class="btn btn-success">Checkout</button>
            <%
            }
            %>
          </form>

        </div>

      </div>
    </div>

    <%@ include file="comment.jsp"%>
    <%@ include file="footer.html"%>

</body>
</html>