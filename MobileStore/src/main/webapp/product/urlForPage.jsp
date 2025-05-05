
<c:if test="${not empty param.keyword}">
    <c:param name="keyword" value="${param.keyword}" />
</c:if>
<c:if test="${not empty param.minPrice}">
    <c:param name="minPrice" value="${param.minPrice}" />
</c:if>
<c:if test="${not empty param.maxPrice}">
    <c:param name="maxPrice" value="${param.maxPrice}" />
</c:if>
<c:if test="${not empty paramValues.cateID}">
    <c:forEach var="cate" items="${paramValues.cateID}">
        <c:param name="cateID" value="${cate}" />
    </c:forEach>
</c:if>
<c:if test="${not empty paramValues.brandID}">
    <c:forEach var="brand" items="${paramValues.brandID}">
        <c:param name="brandID" value="${brand}" />
    </c:forEach>
</c:if>