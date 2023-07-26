<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

    <div id="small-product">
        <img id="product-icon" src="${param.image}" alt="Product image">

        <div id="product-info">
            <span id="product-name">${param.name}</span>
            <div id="product-prices">
                <span id="total-price">
                    <fmt:formatNumber value="${param.unit_price * param.qty}" pattern=".00$" />
                </span>
                <span id="unit-price">
                    <fmt:formatNumber value="${param.unit_price}" pattern="(.00$/u)" />
                </span>
            </div>
            <span id="product-qty">x${param.qty}</span>
        </div>

        <div id="actions">
            <img id="add-basket" class="btn btn-icon" src="images/icons/basket.png" alt="Add the product to a basket">
            <img id="remove" class="btn btn-icon" src="images/icons/close.png" alt="Remove the product">
        </div>
    </div>