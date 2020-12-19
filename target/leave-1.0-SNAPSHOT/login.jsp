<div class="login-page">
    <div class="form">
        <form action="" class="login-form" method="post">
            <input name="email" placeholder="Email" type="email" value="<%= request.getParameter("email") != null ? request.getParameter("email") : "" %>">
            <input name="password" placeholder="Password" type="password">
            <input name="login" type="submit" value="Login">
        </form>
        <%
            if (request.getParameter("login") != null && id == null) {
                out.print("<div class='error'>Please verify your login details</div>");
            }
        %>
    </div>
</div>
