<%@ include file="fragments/header.jspf" %>
<div class="row justify-content-center"><div class="col-lg-8">
    <a href="${pageContext.request.contextPath}/admin/products" class="text-secondary text-decoration-none">← Back to products</a>
    <h1 class="h2 fw-bold my-3"><c:out value="${pageTitle}"/></h1>
    <div class="card border-0 shadow-sm"><div class="card-body p-4">
    <form method="post" action="${pageContext.request.contextPath}/admin/products/save">
        <input type="hidden" name="id" value="${product.id}">
        <div class="mb-3"><label class="form-label" for="name">Product name</label><input class="form-control" id="name" name="name" maxlength="120" value="<c:out value='${product.name}'/>" required><c:if test="${not empty validationErrors}"><div class="text-danger small"><c:forEach var="validationError" items="${validationErrors}"><div><c:out value="${validationError.defaultMessage}"/></div></c:forEach></div></c:if></div>
        <div class="mb-3"><label class="form-label" for="description">Description</label><textarea class="form-control" id="description" name="description" rows="3" maxlength="1000" required><c:out value="${product.description}"/></textarea></div>
        <div class="row"><div class="col-md-6 mb-3"><label class="form-label" for="price">Price (₹)</label><input class="form-control" id="price" name="price" type="number" step="0.01" min="0.01" value="${product.price}" required></div>
        <div class="col-md-6 mb-3"><label class="form-label" for="stock">Stock quantity</label><input class="form-control" id="stock" name="stock" type="number" min="0" value="${product.stock}" required></div></div>
        <div class="mb-4"><label class="form-label" for="imageUrl">Image URL (optional)</label><input class="form-control" id="imageUrl" name="imageUrl" type="url" maxlength="500" value="<c:out value='${product.imageUrl}'/>"></div>
        <button class="btn btn-primary" type="submit">Save product</button> <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/admin/products">Cancel</a>
    </form>
    </div></div>
</div></div>
<%@ include file="fragments/footer.jspf" %>
