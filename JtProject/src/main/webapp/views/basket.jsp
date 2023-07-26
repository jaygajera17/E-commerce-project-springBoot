<%@page import="java.util.*" %>
    <%@page import="com.jtspringproject.JtSpringProject.models.Product" %>
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
            <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

                <% List<Product> products = (List<Product>) request.getAttribute("products");

                        float basketSubtotal = 0.0f;
                        float couponDiscount = 0.0f;
                        float basketTotal = 0.0f;

                        for (Product product : products) {
                        basketSubtotal += product.getPrice() * product.getQuantity();
                        }

                        basketTotal = basketSubtotal - couponDiscount;

                        request.setAttribute("basketSubtotal", basketSubtotal);
                        request.setAttribute("couponDiscount", couponDiscount);
                        request.setAttribute("basketTotal", basketTotal);
                        %>

                        <script lang="text/javascript">
                            $(document).ready(function () {

                                // Sets the basket overlay open trigger event handler
                                $(".basket #overlay").on("basketOverlayOpen", function () {
                                    $(".basket #overlay").removeClass("disabled");
                                    $(".basket #overlay").addClass("enabled");
                                });

                                // Sets the basket overlay close trigger event handler
                                $(".basket #overlay").on("basketOverlayClose", function () {
                                    $(".basket #overlay").removeClass("enabled");
                                    $(".basket #overlay").addClass("disabled");
                                });
                            });
                        </script>

                        <div id="${param.type}" class="basket ${param.visibility}">
                            <div id="overlay" class="disabled">
                                <div id="overlay-content">
                                    <span id="title">Head's Up :)</span>
                                    <span id="content">You are <span id="coupon-amount">
                                            <fmt:formatNumber value="${param.basketSubtotalUntilCoupon}" pattern=".00$" />
                                        </span> away from getting a 5$ coupon on your main basket!</span>
                                </div>
                            </div>

                            <div id="basket-header" class="spanning-row">
                                <span>${param.name}</span>
                                <img class="basket-type-switch btn btn-icon" src="images/icons/switch.png" alt="Switches the current displayed basket">
                            </div>
                            <div id="products-container">
                                <c:forEach var="product" items="${products}">
                                    <jsp:include page="smallProduct.jsp">
                                        <jsp:param name="name" value="${product.name}" />
                                        <jsp:param name="image" value="${product.image}" />
                                        <jsp:param name="unit_price" value="${product.price}" />
                                        <jsp:param name="qty" value="${product.quantity}" />
                                    </jsp:include>
                                </c:forEach>
                            </div>

                            <div id="basket-summary">
                                <div id="sub-total" class="spanning-row">
                                    <span>Sub-total</span> <span class="amount">
                                        <fmt:formatNumber value="${basketSubtotal}" pattern=".00$" />
                                    </span>
                                </div>

                                <div id="coupons" class="spanning-row">
                                    <span>Coupons</span> <span class="amount">
                                        <fmt:formatNumber value="${couponDiscount}" pattern="-0.00$" />
                                    </span>
                                </div>

                                <div id="total" class="spanning-row">
                                    <span>Total</span> <span class="amount">
                                        <fmt:formatNumber value="${basketTotal}" pattern=".00$" />
                                    </span>
                                </div>

                                <div id="actions" class="btn-container spanning-row">
                                    <div class="btn-container">
                                        <a class="btn btn-primary"><span>Checkout</span></a>
                                    </div>
                                    <img class="btn btn-icon" src="images/icons/delete.png" alt="Empty this basket button">
                                </div>
                            </div>
                        </div>