<%@ include file="fragments/header.jspf" %>
<h1 class="h2 fw-bold mb-4">Your cart</h1>
<c:choose>
<c:when test="${empty items}">
    <div class="empty-state text-center"><h2 class="h4">Your cart is empty</h2><p class="text-secondary">Discover something useful for your day.</p><a href="${pageContext.request.contextPath}/" class="btn btn-primary">Continue shopping</a></div>
</c:when>
<c:otherwise>
    <div class="table-responsive">
    <table class="table align-middle bg-white">
        <thead><tr><th>Product</th><th>Price</th><th style="width:180px">Quantity</th><th>Subtotal</th><th></th></tr></thead>
        <tbody>
        <c:forEach var="item" items="${items}">
        <tr>
            <td class="fw-semibold"><c:out value="${item.product.name}"/></td>
            <td>₹<c:out value="${item.product.price}"/></td>
            <td><form class="d-flex gap-2" method="post" action="${pageContext.request.contextPath}/cart/update/${item.product.id}">
                <input class="form-control form-control-sm" type="number" min="0" max="${item.product.stock}" name="quantity" value="${item.quantity}">
                <button class="btn btn-sm btn-outline-secondary">Update</button>
            </form></td>
            <td class="fw-semibold">₹<c:out value="${item.subtotal}"/></td>
            <td><form method="post" action="${pageContext.request.contextPath}/cart/remove/${item.product.id}"><button class="btn btn-sm btn-outline-danger">Remove</button></form></td>
        </tr>
        </c:forEach>
        </tbody>
    </table>
    </div>
    <div class="d-flex flex-column flex-sm-row justify-content-between align-items-sm-center gap-3 mt-4">
        <a href="${pageContext.request.contextPath}/" class="btn btn-outline-dark">Continue shopping</a>
        <div class="text-sm-end"><div class="text-secondary">Order total</div><div class="price fs-3 mb-2">₹<c:out value="${total}"/></div><a href="${pageContext.request.contextPath}/checkout" class="btn btn-primary btn-lg">Proceed to checkout</a></div>
    </div>
</c:otherwise>
</c:choose>
<%@ include file="fragments/footer.jspf" %>
