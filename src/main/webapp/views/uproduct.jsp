<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="java.text.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!doctype html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0,
          maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">

    <link rel="stylesheet"
          href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
          integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh"
          crossorigin="anonymous">

    <title>Products</title>
</head>

<body class="bg-light">

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">

        <a class="navbar-brand" href="#">
            <img
                src="../static/images/logo.png"
                width="auto"
                height="40"
                class="d-inline-block align-top"
                alt="Logo" />
        </a>

        <button class="navbar-toggler"
                type="button"
                data-toggle="collapse"
                data-target="#navbarSupportedContent"
                aria-controls="navbarSupportedContent"
                aria-expanded="false"
                aria-label="Toggle navigation">

            <span class="navbar-toggler-icon"></span>

        </button>

        <div class="collapse navbar-collapse" id="navbarSupportedContent">

            <ul class="navbar-nav mr-auto"></ul>

            <ul class="navbar-nav">

                <li class="nav-item active">
                    <a class="nav-link" href="/adminhome">
                        Home Page
                    </a>
                </li>

                <li class="nav-item active">
                    <a class="nav-link" href="/logout">
                        Logout
                    </a>
                </li>

            </ul>

        </div>
    </div>
</nav>


<div class="container-fluid">

    <!-- Search -->
    <div class="mb-4 mt-3">

        <form action="/user/products" method="get" class="form-inline">

            <input
                type="text"
                name="search"
                value="${search}"
                class="form-control mr-2"
                placeholder="Search products...">

            <button type="submit" class="btn btn-primary">
                Search
            </button>

            <c:if test="${not empty search}">
                <a href="/user/products"
                   class="btn btn-secondary ml-2">
                    Clear
                </a>
            </c:if>

        </form>

    </div>


    <!-- No results message -->
    <c:if test="${not empty msg}">
        <div class="alert alert-info mt-3">
            ${msg}
        </div>
    </c:if>


    <!-- Products -->
    <c:if test="${not empty products}">

        <table class="table">

            <thead>
            <tr>
                <th scope="col">Serial No.</th>
                <th scope="col">Product Name</th>
                <th scope="col">Category</th>
                <th scope="col">Preview</th>
                <th scope="col">Quantity</th>
                <th scope="col">Price</th>
                <th scope="col">Weight</th>
                <th scope="col">Description</th>
                <th scope="col">Buy</th>
            </tr>
            </thead>

            <tbody>

            <c:forEach var="product" items="${products}">

                <tr>

                    <td>
                        ${product.id}
                    </td>

                    <td>
                        ${product.name}
                    </td>

                    <td>
                        ${product.category.name}
                    </td>

                    <td>
                        <img src="${product.image}"
                             height="100px"
                             width="100px"
                             alt="${product.name}">
                    </td>

                    <td>
                        ${product.quantity}
                    </td>

                    <td>
                        ${product.price}
                    </td>

                    <td>
                        ${product.weight}
                    </td>

                    <td>
                        ${product.description}
                    </td>

                    <td>

                        <form action="/products/addtocart" method="get">

                            <input type="hidden"
                                   name="id"
                                   value="${product.id}">

                            <input type="submit"
                                   value="Add To Cart"
                                   class="btn btn-warning">

                        </form>

                    </td>

                </tr>

            </c:forEach>

            </tbody>

        </table>

    </c:if>

</div>


<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"
        integrity="sha384-J6qa4849blOp4+u9J7K1p5Q3XK8cF8N4L6H9D7K3F5L2"
        crossorigin="anonymous"></script>

<script
    src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
    crossorigin="anonymous">
</script>

<script
    src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"
    crossorigin="anonymous">
</script>

</body>
</html>