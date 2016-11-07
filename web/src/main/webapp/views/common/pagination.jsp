<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="row text-center">
    <div class="col-md-12">
        <ul class="pagination" id="pagination">
            <c:if test="${pageInfo.pageNum!=1}">
                <li>
                    <a href="#" pageNum="${pageInfo.pageNum-1}">上一页</a>
                </li>
            </c:if>
            <%--DONE 小于等于10--%>
            <c:if test="${pageInfo.pages<11}">
                <c:forEach begin="1" end="${pageInfo.pages}" var="index">
                    <c:if test="${pageInfo.pageNum==index}">
                        <li class="active"><a href="#">${index}</a></li>
                    </c:if>
                    <c:if test="${pageInfo.pageNum!=index}">
                        <li><a href="#">${index}</a></li>
                    </c:if>
                </c:forEach>
            </c:if>
            <%--DONE 状态A--%>
            <c:if test="${pageInfo.pages>10}">
                <c:if test="${pageInfo.pageNum<10}">
                    <c:forEach begin="1" end="9" var="index">
                        <c:if test="${pageInfo.pageNum==index}">
                            <li class="active"><a href="#">${index}</a></li>
                        </c:if>
                        <c:if test="${pageInfo.pageNum!=index}">
                            <li><a href="#">${index}</a></li>
                        </c:if>
                    </c:forEach>
                    <li>
                        <a href="#" pageNum="${pageInfo.pages}">→${pageInfo.pages}</a>
                    </li>
                </c:if>
                <%--DONE 状态B--%>
                <c:if test="${pageInfo.pageNum>9 && pageInfo.pages-pageInfo.pageNum>8}">
                    <li>
                        <a href="#" pageNum="1">1←</a>
                    </li>
                    <c:forEach begin="${pageInfo.pageNum-4}" end="${pageInfo.pageNum-1}" var="index">
                        <li>
                            <a href="#">${index}</a>
                        </li>
                    </c:forEach>
                    <li class="active">
                        <a href="#">${pageInfo.pageNum}</a>
                    </li>
                    <c:forEach begin="${pageInfo.pageNum+1}" end="${pageInfo.pageNum+4}" var="index">
                        <li>
                            <a href="#">${index}</a>
                        </li>
                    </c:forEach>
                    <li>
                        <a href="#" pageNum="${pageInfo.pages}">→${pageInfo.pages}</a>
                    </li>
                </c:if>
                <%--DONE 状态C--%>
                <c:if test="${pageInfo.pageNum>9 && pageInfo.pages-pageInfo.pageNum<9}">
                    <li>
                        <a href="#" pageNum="1">1←</a>
                    </li>
                    <c:forEach begin="${pageInfo.pages-8}" end="${pageInfo.pages}" var="index">
                        <c:if test="${pageInfo.pageNum==index}">
                            <li class="active"><a href="#">${index}</a></li>
                        </c:if>
                        <c:if test="${pageInfo.pageNum!=index}">
                            <li><a href="#">${index}</a></li>
                        </c:if>
                    </c:forEach>
                </c:if>
            </c:if>
            <c:if test="${pageInfo.pages!=pageInfo.pageNum && pageInfo.pages!=0}">
                <li>
                    <a href="#" pageNum="${pageInfo.pageNum+1}">下一页</a>
                </li>
            </c:if>
            <li style="font-size: 24px">
                &nbsp;&nbsp;&nbsp;共${pageInfo.total}条记录
            </li>
        </ul>
    </div>
</div>