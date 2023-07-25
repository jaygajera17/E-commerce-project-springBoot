<div id="${param.type}" class="basket ${param.visibility_class}">
    <div id="basket-header" class="spanning-row">
        <span>${param.name}</span>
        <img class="basket-type-switch btn btn-icon" src="images/icons/switch.png" alt="Switches the current displayed basket">
    </div>

    <div id="products-container">
        <c:forEach var="product" items="${products}">
            <jsp:include page="smallProduct.jsp">
                <jsp:param name="name" value="${product.name}" />
                <jsp:param name="unit_price" value="${product.price}" />
                <jsp:param name="qty" value="${product.quantity}" />
            </jsp:include>
        </c:forEach>
    </div>

    <div id="basket-summary">
        <div id="sub-total" class="spanning-row">
            <span>Sub-total</span> <span class="amount">0.00$</span>
        </div>

        <div id="coupons" class="spanning-row">
            <span>Coupons</span> <span class="amount">-0.00$</span>
        </div>

        <div id="total" class="spanning-row">
            <span>Total</span> <span class="amount">0.00$</span>
        </div>

        <div id="actions" class="btn-container spanning-row">
            <div class="btn-container">
                <a class="btn btn-primary"><span>Checkout</span></a>
            </div>
            <img class="btn btn-icon" src="images/icons/delete.png" alt="Empty this basket button">
        </div>
    </div>
</div>