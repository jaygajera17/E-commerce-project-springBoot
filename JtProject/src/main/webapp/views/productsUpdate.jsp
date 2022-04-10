<!doctype html>
<%@page import="java.sql.*"%>
<html lang="en" xmlns:th="http://www.thymeleaf.org">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
	integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.7.0/css/all.css"
	integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ"
	crossorigin="anonymous">
<title>Document</title>
</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
		<div class="container-fluid">
			<a class="navbar-brand" href="#"> <img
				th:src="@{/images/logo.png}" src="../static/images/logo.png"
				width="auto" height="40" class="d-inline-block align-top" alt="" />
			</a>
			<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>

			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav mr-auto"></ul>
				<ul class="navbar-nav">
					<li class="nav-item active"><a class="nav-link"
						href="/adminhome" >Home Page</a></li>
					<li class="nav-item active"><a class="nav-link"
						href="/logout" >Logout</a></li>

				</ul>

			</div>
		</div>
	</nav><br>
	<div class="jumbotron container border border-info">
		<h3>Update Existing Product</h3>
		<form action="updateData" method="post">
			<div class="row">
				<div class="col-sm-5">
					
					<div class="form-group">
						<label for="name">Id</label> 
						<input type="number" readonly="readonly" class="form-control border border-success" name="id"  value="${ pid }">
						

					</div>
					<div class="form-group">
						<label for="name">Name</label> 
						<input type="text" class="form-control border border-success" required name="name" value="${pname }" placeholder="Enter name">
					</div>
					
					<div class="form-group">
					
						<label for="category">Select Category</label> 
						<select class="form-control border border-success" name="categoryid" readonly>
							
							<option >${ pcategory }</option>
						</select>
					</div>
					<div class="form-group">
						<label for="price">Price</label> 
						<input type="number" class="form-control border border-success" required name="price" value="${ pprice }" min="1" placeholder="Price">
					</div>
					<div class="form-group">
						<label for="weight">Weight in grams</label> 
						<input type="number" class="form-control border border-success" required name="weight" value="${ pweight }" min="1" placeholder="Weight">
					</div>
					<div class="form-group">
						<label for="weight">Available Quantity</label> 
						<input type="number" class="form-control border border-success" required name="quantity" value="${ pquantity }" min="1" placeholder="Quantity">
					</div>
					
					
				</div>
				
				<div class="col-sm-5">
				<div class="form-group">
						<label for="description">Product Description</label>
						<textarea class="form-control border border-success" rows="4" name="description" placeholder="Product Details" value= "${ pdescription }"></textarea>
					</div>
					<p>Product Image</p>
					<div class="custom-file">
						<input type="file" class="custom-file-input" name="productImage" value="${ pimage }" accept="image/jpeg, image/png" id="productImage"  onchange="loadfile(event)"/> 
						<label class="custom-file-label border border-success" for="productImage">Choose file</label>
						<script type="text/javascript">
						var loadFile = function(event) {
							var image = document.getElementById('imgPreview');
							image.src = URL.createObjectURL(event.target.files[0]);
						};
						</script>
					</div>
					<div class="form-group">
						<img src="#" id="imgPreview" height="100px" width="100px"
							style="margin-top: 20px" alt=" ">
					</div>
					<input type="hidden" name="imgName">
					<input type="submit" value="Update Details" class="btn btn-primary">
				</div>
			</div>
		</form>
	</div>

	<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"
		integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
		integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
		crossorigin="anonymous"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"
		integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6"
		crossorigin="anonymous"></script>
</body>
</html>