<%@ include file="fragments/header.jspf" %>
<div class="empty-state text-center py-5">
    <div class="success-mark mb-3">✓</div>
    <h1 class="h2 fw-bold">Thank you for your order!</h1>
    <c:if test="${not empty orderId}"><p class="text-secondary">Your order number is <strong>#<c:out value="${orderId}"/></strong>.</p></c:if>
    <c:if test="${not empty orderTotal}"><p class="price fs-4">Total paid at checkout: ₹<c:out value="${orderTotal}"/></p></c:if>
    <p class="text-secondary">This demo records the order but does not process online payments.</p>
    <a href="${pageContext.request.contextPath}/" class="btn btn-primary">Back to shop</a>
</div>
<%@ include file="fragments/footer.jspf" %>
