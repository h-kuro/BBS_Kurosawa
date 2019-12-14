<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% request.setCharacterEncoding("UTF-8"); %>
<html>

    <%
    if (request.getAttribute("auth") == null) {
        String path = "/Auth";
        RequestDispatcher dispatch = request.getRequestDispatcher(path);
        dispatch.forward(request, response);
    }
%>

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

<% if (request.getAttribute("auth") != null) { %>
<% if (request.getAttribute("auth").equals("true")) {%>
<div class="Color Common">
    <form action="/bbs/Request" method="post" class="FormStyle">
        <input type="hidden" name="type" value="delete">
        <input type="hidden" name="id" value=<%= request.getParameter("id") %>>
        <div class="ButtonStyle">
            <input type="submit" value="削除">
            <input type="button" value="キャンセル" onclick="window.close(); return false;">
        </div>
    </form>
</div>
<% } else { %>
<div class="Color Common">
    <p>パスワードが正しくありません。</p>
    <div class="ButtonStyle">
        <input type="button" value="閉じる" onclick="window.close(); return false;">
    </div>
</div>
<% } %>
<% } %>

<footer>
    <p>©Kurosawa Hiroya</p>
</footer>
</body>