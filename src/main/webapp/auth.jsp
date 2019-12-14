<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% request.setCharacterEncoding("UTF-8"); %>
<html>

<head>
    <title>掲示板</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href="/bbs/css/style.css" rel="stylesheet" type="text/css"/>
    <script src="/bbs/js/jquery.min.js" defer="defer"></script>
    <script src="/bbs/js/submit.js" defer="defer"></script>
</head>

<body>
<header>
    <h2>掲示板</h2>
</header>
<div class="Color Common">
    <% if (request.getParameter("type").equals("delete")) { %>
    <form action="/bbs/delete.jsp" method="post" id="Auth">
        <fieldset>
            <label>パスワード:</label><input type="password" name="password" maxlength="32" required>
            <div class="ButtonStyle">
                <input type="hidden" name="type" value=<%= request.getParameter("type") %>>
                <input type="hidden" name="id" value=<%= request.getParameter("id") %>>
                <input type="submit" value="認証">
                <input type="button" value="閉じる" onclick="window.close(); return false;">
            </div>
        </fieldset>
    </form>
    <% } else if (request.getParameter("type").equals("update")) {%>
    <form action="/bbs/update.jsp" method="post" id="Auth">
        <fieldset>
            <label>パスワード:</label><input type="password" name="password" maxlength="32" required>
            <div class="ButtonStyle">
                <input type="hidden" name="type" value=<%= request.getParameter("type") %>>
                <input type="hidden" name="id" value=<%= request.getParameter("id") %>>
                <input type="submit" value="認証">
                <input type="button" value="閉じる" onclick="window.close(); return false;">
            </div>
        </fieldset>
    </form>
    <% } %>
</div>
<footer>
    <p>©Kurosawa Hiroya</p>
</footer>
</body>