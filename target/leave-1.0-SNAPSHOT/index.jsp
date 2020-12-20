<%@ page import="controller.Controller" %>
<%@ page import="controller.Leaves" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <link href="img/logo1.svg" rel="icon">
    <link href="style/style.css" rel="stylesheet" type="text/css">
    <link href="style/login.css" rel="stylesheet" type="text/css">
    <link href="style/table.css" rel="stylesheet" type="text/css">
    <meta charset="UTF-8">
    <title>foo(d) Leave management</title>
</head>
<body>
<div id="background">
    <div id="img1"></div>
    <div id="img2"></div>
</div>
<div id="foreground">
    <div id="title">
        <img alt="Logo" id="logo" src="img/logo1.svg">
        <h1>foo(d)</h1>
        <div id="social">
            <a href="https://www.facebook.com/Foo-d-112920380609130" rel="noopener noreferrer" target="_blank">
                <img alt="Facebook" src="img/f_logo_RGB-Blue_1024.png">
            </a>
            <a href="https://www.instagram.com/foo_d_resto/" rel="noopener noreferrer" target="_blank">
                <img alt="Instagram" src="img/1024px-Instagram_logo_2016.svg.webp">
            </a>
            <a href="https://twitter.com/foo_d_resto" rel="noopener noreferrer" target="_blank">
                <img alt="Twitter" src="img/Twitter_Social_Icon_Circle_Color.png">
            </a>
        </div>
    </div>
    <div id="home0">
        <%
            String id = null;
            if (request.getParameter("login") != null) {
                id = Controller.login(request.getParameter("email"),
                    request.getParameter("password"));
                if (id != null) {
                    session.setAttribute("id", id);
                }
            }
            if (request.getParameter("logout") != null) {
                id = null;
                session.removeAttribute("id");
            }
            if (session.getAttribute("id") != null) {
       %>
       <%@ include file="home.jsp" %>
       <% } else { %>
       <%@ include file="login.jsp" %>
       <% } %>
    </div>
    <div>
        <h1 class="unselectable">&nbsp</h1>
    </div>
</div>
</body>
</html>
