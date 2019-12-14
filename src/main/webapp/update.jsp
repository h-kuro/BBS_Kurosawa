<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%
    if (request.getAttribute("auth") == null) {
        String path = "/Auth";
        RequestDispatcher dispatch = request.getRequestDispatcher(path);
        dispatch.forward(request, response);
    }
%>

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

<% if (request.getAttribute("auth") != null) { %>
<% if (request.getAttribute("auth").equals("true")) {%>
<div class="Color Common">
    <%
        final String url = "jdbc:mysql://localhost:3306/bbs?UTF-8&serverTimezone=JST";
        final String user = "root";
        final String password = "password";
        final String sql = "SELECT * FROM post WHERE id=" + request.getParameter("id");
        Connection conn;
        conn = DriverManager.getConnection(url, user, password);
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery(sql);
        rs.next();
    %>
    <form action="/bbs/Request" method="post" class="FormStyle">
        <input type="hidden" name="type" value="update">
        <input type="hidden" name="id" value=<%= request.getParameter("id") %>>
        <fieldset>
            <table>
                <tr>
                    <th><label>タイトル:</label></th>
                    <td><input type="text" name="title" maxlength="32" value=<%= rs.getString(2) %> required></td>
                </tr>
                <tr>
                    <th><label>お名前:</label></th>
                    <td><input type="text" name="name" maxlength="32" value=<%= rs.getString(3) %> required></td>
                </tr>
                <tr>
                    <th><label>本文:</label></th>
                    <td><textarea name="message" rows="5" maxlength="2048"
                                  required><%= rs.getString(6) %></textarea></label>
                    </td>
                </tr>
            </table>
        </fieldset>
        <div class="ButtonStyle">
            <input type="submit" value="更新">
            <input type="button" value="キャンセル" onclick="window.close(); return false;">
        </div>
    </form>
</div>
<%
    rs.close();
    stmt.close();
%>
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