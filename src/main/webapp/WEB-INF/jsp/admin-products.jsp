<%@ include file="fragments/header.jspf" %>
<div class="d-flex flex-column flex-sm-row justify-content-between align-items-sm-center gap-3 mb-4">
    <div><h1 class="h2 fw-bold mb-1">Manage products</h1><p class="text-secondary mb-0">Create, update, and remove products.</p></div>
    <a href="${pageContext.request.contextPath}/admin/products/new" class="btn btn-primary">+ Add product</a>
</div>
<div class="table-responsive"><table class="table table-hover align-middle bg-white">
<thead><tr><th>ID</th><th>Product</th><th>Price</th><th>Stock</th><th>Actions</th></tr></thead>
<tbody><c:forEach var="product" items="${products}">
<tr><td><c:out value="${product.id}"/></td><td><div class="fw-semibold"><c:out value="${product.name}"/></div><div class="small text-secondary"><c:out value="${product.description}"/></div></td>
<td>₹<c:out value="${product.price}"/></td><td><c:out value="${product.stock}"/></td><td><div class="d-flex gap-2">
<a class="btn btn-sm btn-outline-primary" href="${pageContext.request.contextPath}/admin/products/${product.id}/edit">Edit</a>
<form method="post" action="${pageContext.request.contextPath}/admin/products/${product.id}/delete" onsubmit="return confirm('Delete this product?')"><button class="btn btn-sm btn-outline-danger">Delete</button></form>
</div></td></tr>
</c:forEach></tbody></table></div>
<%@ include file="fragments/footer.jspf" %>
