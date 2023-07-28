<%@page import="java.sql.*" %>
  <%@page import="java.util.*" %>
    <%@page import="java.text.*" %>
      <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <!DOCTYPE html>
        <html lang="en" xmlns:th="http://www.thymeleaf.org" xmlns:sec="http://www.thymeleaf.org/thymeleaf-extras-springsecurity3">

          <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
            <meta http-equiv="X-UA-Compatible" content="ie=edge">
            <script src="https://code.jquery.com/jquery-3.7.0.slim.min.js" integrity="sha256-tG5mcZUtJsZvyKAxYLVXrmjKBVLd6VpVccqz/r4ypFE=" crossorigin="anonymous"></script>
            <link rel="preconnect" href="https://fonts.googleapis.com">
            <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
            <link href="https://fonts.googleapis.com/css2?family=Autour+One&family=Cabin:ital,wght@0,400;0,500;0,600;0,700;1,400;1,500;1,600;1,700&display=swap" rel="stylesheet">
            <link rel="stylesheet" type="text/css" href="style.css">
            <title>Store Front</title>

            <script type="text/javascript">
              $(document).ready(function () {
                let isCustomBasket = false;

                let basket = $("#basket");
                let customBasket = $("#custom-basket");

                // Toggle between the two baskets
                $(".basket-type-switch").on("click", toggleBasketType);

                // Redirect to the admin portal
                $("#admin-btn").on("click", () => location.href = "admin/loginvalidate");

                // Logout
                $("#logout-btn").on("click", () => location.href = "userlogout");

                // Show the basket overlay after 5 seconds
                setTimeout(function () {
                  $(".basket #overlay").trigger("basketOverlayOpen");

                  setTimeout(function () {
                    $(".basket #overlay").trigger("basketOverlayClose");
                  }, 5000);
                }, 2000);

                // Toggle between login and register
                function toggleBasketType() {
                  isCustomBasket = !isCustomBasket;

                  updateBasket();
                }

                // Updates the currently displayed basket
                function updateBasket() {
                  if (isCustomBasket) {
                    customBasket.removeClass("disabled");
                    customBasket.addClass("enabled");
                    basket.addClass("disabled");
                    basket.removeClass("enabled");
                  } else {
                    customBasket.addClass("disabled");
                    customBasket.removeClass("enabled");
                    basket.addClass("enabled");
                    basket.removeClass("disabled");
                  }
                }
              });
            </script>
          </head>

          <header>
            <img id="logo" src="images/nyan_logo_nobg.png" alt="Store icon" width="48px" height="48px">

            <h3>
              Nyan Groceries
            </h3>

            <c:if test="${user.getRole() == 'ROLE_ADMIN'}">
              <img id="admin-btn" src="images/icons/admin.png" alt="Admin portal icon" class="btn btn-icon">
            </c:if>

            <img id="logout-btn" src="images/icons/exit.png" alt="Admin portal icon" class="btn btn-icon">
          </header>

          <body id="store-body">

            <!-- Storefront -->
            <div id="storefront">

              <!-- Product Carousel -->
              <div id="store-carousel">
                <c:forEach var="product" items="${products}" varStatus="loopStatus">
                  <c:if test="${loopStatus.index < 1}"> <!-- change 1 to desired # products in carousel -->
                    <div class="product">
                      <div class="product-details">
                        <h5 class="product-name">${product.name}</h5>
                        <h5 class="product-price">$${product.price}</h5>
                      </div>
                      <img class="product-img" src="${product.image}" alt="Product">
                      <div class="product-buttons">
                        <a href="#" class="btn btn-primary btn-basket"><img src="images/icons/basket.png" alt="Basket" width="40"></a>
                        <a href="#" class="btn btn-primary btn-custombasket"><img src="images/icons/custombasket.png" alt="Basket" width="40"></a>
                      </div>
                    </div>
                  </c:if>
                </c:forEach>
              </div>

              <!-- Store List -->
              <div id="store-list">
                <c:forEach var="product" items="${products}">
                  <div class="product">
                    <img class="product-img" src="${product.image}" alt="Product">
                    <div class="product-details">
                      <h5 class="product-name">${product.name}</h5>
                      <h5 class="product-price">$${product.price}</h5>
                    </div>
                    <div class="product-buttons">
                      <a href="#" class="btn btn-primary btn-basket"><img src="images/icons/basket.png" alt="Basket" width="25"></a>
                      <a href="#" class="btn btn-primary btn-custombasket"><img src="images/icons/custombasket.png" alt="Basket" width="25"></a>
                    </div>
                  </div>
                </c:forEach>
              </div>
            </div>

            <!-- Baskets -->
            <div id="baskets-container">
              <jsp:include page="basket.jsp">
                <jsp:param name="visibility" value="enabled" />
                <jsp:param name="type" value="basket" />
                <jsp:param name="name" value="Basket" />
                <jsp:param name="basketSubtotalUntilCoupon" value="17.62" />
              </jsp:include>

              <jsp:include page="basket.jsp">
                <jsp:param name="visibility" value="disabled" />
                <jsp:param name="type" value="custom-basket" />
                <jsp:param name="name" value="Custom Basket" />
                <jsp:param name="basketSubtotalUntilCoupon" value="17.62" />
              </jsp:include>
            </div>

          </body>

        </html>

        <!-- <section class="store">
              <div class="row">
                <c:forEach var="product" items="${products}">
                  <div class="col-md-3">
                    <div class="card mb-4">
                      <img class="card-img-top" src="${product.image}" alt="Product 1">
                      <div class="card-body">
                        <b>
                          <h4 class="card-title">${product.name}</h4>
                        </b>
                        <h5 class="card-text">Category: ${product.category.name}</h5>
                        <h5 class="card-text">Price: ${product.price}</h5>
                        <p class="card-text">Description: ${product.description}</p>
                        <a href="#" class="btn btn-primary">Add to Cart</a>
                      </div>
                    </div>
                  </div>
                </c:forEach>
              </div>
            </div>
            </section> -->
        <!-- <nav class="navbar navbar-expand-lg navbar-light bg-light">
                  <div class="container-fluid">
                    <a class="navbar-brand" href="#">
                      <img th:src="@{/images/logo.png}" src="../static/images/logo.png" width="auto" height="40" class="d-inline-block align-top" alt="" />
                    </a>
                    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                      <span class="navbar-toggler-icon"></span>
                    </button>

                    <div class="collapse navbar-collapse" id="navbarSupportedContent">
                      <h4>Welcome ${ username } </h4>
                      <ul class="navbar-nav mr-auto"></ul>
                      <ul class="navbar-nav">
                        <li class="nav-item active">
                          <a class="nav-link" th:href="@{/}" href="#">Cart</a>
                        </li>
                        <li class="nav-item active">
                          <a class="nav-link" href="profileDisplay">Profile</a>
                        </li>
                        <li class="nav-item active">
                          <a class="nav-link" sec:authorize="isAuthenticated()" href="logout">Logout</a>
                        </li>

                      </ul>

                    </div>
                  </div>
                </nav> -->
        <!-- <html lang="en">

                  <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>Perishable Shop</title>
                    <style>
                      body {
                        padding: 20px;
                      }

                      .card-body {
                        height: 250px;
                        /* Set a fixed height for the card body */
                      }

                      .card-img-top {
                        max-height: 100px;
                        /* Limit the height of the product image */
                        object-fit: contain;
                      }
                    </style>
                  </head>

                  <body class="bg-light">
                    <header>

                    </header>
                    <main>

                      <div class="container">
                        <h1>Welcome to Perishable Shop</h1>


                        <div class="row">
                          <c:forEach var="product" items="${products}">
                            <div class="col-md-3">
                              <div class="card mb-4">
                                <img class="card-img-top" src="${product.image}" alt="Product 1">
                                <div class="card-body">
                                  <b>
                                    <h4 class="card-title">${product.name}</h4>
                                  </b>
                                  <h5 class="card-text">Category: ${product.category.name}</h5>
                                  <h5 class="card-text">Price: ${product.price}</h5>
                                  <p class="card-text">Description: ${product.description}</p>
                                  <a href="#" class="btn btn-primary">Add to Cart</a>
                                </div>
                              </div>
                            </div>
                          </c:forEach>
                        </div>

                      </div>
                    </main>
                    <footer>
                      <div class="container">
                        <p>&copy; 2023 Perishable Shop. All rights reserved.</p>
                      </div>
                    </footer>
                  </body>

                </html> -->