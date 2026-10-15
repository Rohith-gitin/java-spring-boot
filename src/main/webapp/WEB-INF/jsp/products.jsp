<%@ include file="fragments/header.jspf" %>
<section class="hero rounded-4 p-4 p-md-5 mb-4">
    <div class="row align-items-center">
        <div class="col-lg-8">
            <p class="text-uppercase fw-semibold small mb-2">Everyday essentials, made easy</p>
            <h1 class="display-5 fw-bold">Find something you'll love.</h1>
            <p class="lead mb-0">Browse the collection and add your favourites to your cart.</p>
        </div>
        <div class="col-lg-4 text-lg-end mt-3 mt-lg-0"><a class="btn btn-light btn-lg" href="${pageContext.request.contextPath}/cart">View cart →</a></div>
    </div>
</section>
<div class="d-flex justify-content-between align-items-center mb-3">
    <div><h2 class="h3 mb-1">Featured products</h2><p class="text-secondary mb-0">Thoughtful picks for everyday life</p></div>
</div>
<div class="row g-4">
<c:choose>
    <c:when test="${empty products}">
        <div class="col-12"><div class="empty-state">No products are available yet. Use Manage products to add your first product.</div></div>
    </c:when>
    <c:otherwise>
        <c:forEach var="product" items="${products}">
            <div class="col-sm-6 col-lg-3">
                <div class="card product-card h-100">
                    <c:choose><c:when test="${not empty product.imageUrl}">
                        <img src="<c:out value='${product.imageUrl}'/>" class="card-img-top product-image" alt="<c:out value='${product.name}'/>" onerror="this.style.display='none'">
                    </c:when><c:otherwise><div class="product-image-placeholder">ShopEase</div></c:otherwise></c:choose>
                    <div class="card-body d-flex flex-column">
                        <h3 class="h5"><c:out value="${product.name}"/></h3>
                        <p class="text-secondary small flex-grow-1"><c:out value="${product.description}"/></p>
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <span class="price">₹<c:out value="${product.price}"/></span>
                            <span class="small text-secondary">Stock: <c:out value="${product.stock}"/></span>
                        </div>
                        <div class="d-grid gap-2">
                            <a class="btn btn-outline-dark" href="${pageContext.request.contextPath}/products/${product.id}">Details</a>
                            <form method="post" action="${pageContext.request.contextPath}/cart/add/${product.id}">
                                <button class="btn btn-primary w-100" type="submit" ${product.stock <= 0 ? 'disabled' : ''}>${product.stock <= 0 ? 'Out of stock' : 'Add to cart'}</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </c:otherwise>
</c:choose>
</div>
<%@ include file="fragments/footer.jspf" %>
