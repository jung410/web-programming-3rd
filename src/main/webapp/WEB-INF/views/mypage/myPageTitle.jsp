<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="col-sm-8 d-flex align-items-center justify-content-center">
    <h3>${loginStat.name}님</h3>
    <c:if test="${loginStat.apiLogin == 1 }">
    <span class="ml-2 d-flex align-items-end"><img src="/images/kakaologo.png" style="width:20px;margin-right: 2px;">${loginStat.userid}</span>
    </c:if>
    <c:if test="${loginStat.apiLogin == 0 }">
    <span class="ml-2 d-flex align-items-end">${loginStat.userid}</span>
    </c:if>
</div>