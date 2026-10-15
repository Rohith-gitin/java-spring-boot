<%@ include file="fragments/header.jspf" %>
<div class="row g-5 align-items-center">
    <div class="col-md-6">
        <c:choose><c:when test="${not empty product.imageUrl}"><img class="img-fluid rounded-4 detail-image" src="<c:out value='${product.imageUrl}'/>" alt="<c:out value='${product.name}'/>"></c:when><c:otherwise><div class="product-image-placeholder detail-image">ShopEase</div></c:otherwise></c:choose>
    </div>
    <div class="col-md-6">
        <a href="${pageContext.request.contextPath}/" class="text-secondary text-decoration-none">← Back to shop</a>
        <h1 class="display-6 fw-bold mt-3"><c:out value="${product.name}"/></h1>
        <p class="text-secondary"><c:out value="${product.description}"/></p>
        <p class="price fs-3">₹<c:out value="${product.price}"/></p>
        <p>Available stock: <strong><c:out value="${product.stock}"/></strong></p>
        <form method="post" action="${pageContext.request.contextPath}/cart/add/${product.id}">
            <button class="btn btn-primary btn-lg" ${product.stock <= 0 ? 'disabled' : ''}>Add to cart</button>
        </form>
    </div>
</div>
<%@ include file="fragments/footer.jspf" %>
