<%@ include file="fragments/header.jspf" %>
<div class="row g-4">
    <div class="col-lg-7">
        <h1 class="h2 fw-bold mb-4">Checkout</h1>
        <div class="card border-0 shadow-sm"><div class="card-body p-4">
            <form method="post" action="${pageContext.request.contextPath}/checkout">
                <div class="mb-3"><label class="form-label" for="customerName">Full name</label><input class="form-control" id="customerName" name="customerName" maxlength="120" required></div>
                <div class="mb-3"><label class="form-label" for="email">Email address</label><input class="form-control" id="email" name="email" type="email" maxlength="200" required></div>
                <div class="mb-4"><label class="form-label" for="shippingAddress">Shipping address</label><textarea class="form-control" id="shippingAddress" name="shippingAddress" rows="3" maxlength="500" required></textarea></div>
                <p class="small text-secondary">Demo checkout only. No payment gateway is connected.</p>
                <button class="btn btn-primary btn-lg" type="submit">Place order · ₹<c:out value="${total}"/></button>
            </form>
        </div></div>
    </div>
    <div class="col-lg-5"><div class="card border-0 shadow-sm"><div class="card-body p-4">
        <h2 class="h5 mb-3">Order summary</h2>
        <c:forEach var="item" items="${items}">
            <div class="d-flex justify-content-between gap-3 mb-2"><span><c:out value="${item.product.name}"/> × <c:out value="${item.quantity}"/></span><span>₹<c:out value="${item.subtotal}"/></span></div>
        </c:forEach>
        <hr><div class="d-flex justify-content-between fw-bold"><span>Total</span><span>₹<c:out value="${total}"/></span></div>
    </div></div></div>
</div>
<%@ include file="fragments/footer.jspf" %>
