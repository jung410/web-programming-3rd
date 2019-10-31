<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
	<!-- header 부분 시작 -->
    <header>
        <nav class="navbar navbar-expand-sm bg-white navbar-light fixed-top border border-top-0 border-left-0 border-right-0">
            <div class="container d-flex justify-content-between">
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <a class="navbar-brand d-flex align-items-center" href="/"><img src="/images/h1_cgv.png" alt=""></a>
                <div class="collapse navbar-collapse" id="collapsibleNavbar">
                    <ul class="navbar-nav ml-auto">
                    	<c:choose>
                    		<c:when test="${empty loginStat}">
	                    		<li class="nav-item">
		                            <a class="nav-link" href="/movie/movieChart">MOVIE</a>
		                        </li>
		                        <li class="nav-item">
		                            <a class="nav-link" href="/reservation/ticketing">RESERVATION</a>
		                        </li>
		                        <li class="nav-item">
		                            <a class="nav-link" href="/user/join">JOIN</a>
		                        </li>
		                        <li class="nav-item">
		                            <a class="nav-link" href="/user/login">LOGIN</a>
		                        </li>
                    		</c:when>
                    		<c:otherwise>
                    			<li class="nav-item">
		                            <a class="nav-link" href="/movie/movieChart">MOVIE</a>
		                        </li>
		                        <li class="nav-item">
		                            <a class="nav-link" href="/reservation/ticketing">RESERVATION</a>
		                        </li>
		                        <li class="nav-item">
		                            <a class="nav-link" href="/myPage/myPageMain">MYGGV</a>
		                        </li>
		                        <li class="nav-item">
		                            <a class="nav-link logout-btn" href="/user/logout">LOGOUT</a>
		                        </li>
                    		</c:otherwise>
                    	</c:choose>
                    </ul>
                </div>
            </div>
        </nav>
    </header>
	<!-- header 부분 종료 -->