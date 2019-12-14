<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>

<html>

<head>
    <title>掲示板</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href="/bbs/css/style.css" rel="stylesheet" type="text/css"/>
    <script src="/bbs/js/jquery.min.js" defer="defer"></script>
    <script src="/bbs/js/common.js" defer="defer"></script>
</head>

<body>

<header>
    <h2>掲示板</h2>
</header>

<div id="PostList">
    <%
        final String url = "jdbc:mysql://localhost:3306/bbs?UTF-8&serverTimezone=JST";
        final String user = "root";
        final String password = "password";
        final String sql = "SELECT * FROM post";
        Connection conn;
        conn = DriverManager.getConnection(url, user, password);
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery(sql);
    %>
    <% while (rs.next()) { %>
    <div class="Post Color">
        <table>
            <tr>
                <td id=<%= rs.getInt(1) %>><%= rs.getInt(1) %>:<%= rs.getString(2) %>
                </td>
            </tr>
            <tr>
                <td>名前:<%= rs.getString(3) %> 投稿日:<%= rs.getTimestamp(5).toString() %>
                </td>
            </tr>
            <tr>
                <td><%= rs.getString(6) %>
                </td>
            </tr>
        </table>
        <input type="button" value="編集" onclick="openWindow('auth.jsp', 'update', <%= rs.getInt(1) %>)">
        <input type="button" value="削除" onclick="openWindow('auth.jsp', 'delete', <%= rs.getInt(1) %>)">
    </div>
    <% }
        rs.close();
        stmt.close();
    %>
</div>

<div id="PostForm" class="Color">
    <form action="/bbs/Request" method="POST" id="AjaxForm" class="FormStyle">
        <input type="hidden" name="type" value="insert">
        <fieldset>
            <table>
                <tr>
                    <input type="button" value="更新" onclick="window.location.reload()" id="Reload"/>
                </tr>
                <tr>
                    <th><label>タイトル:</label></th>
                    <td><input type="text" name="title" maxlength="32" required></td>
                </tr>
                <tr>
                    <th><label>お名前:</label></th>
                    <td><input type="text" name="name" maxlength="32" required></td>
                </tr>
                <tr>
                    <th><label>パスワード:</label></th>
                    <td><input type="password" name="password" maxlength="32" required></td>
                </tr>
                <tr>
                    <th><label>本文:</label></th>
                    <td><textarea name="message" rows="5" maxlength="2048" required></textarea></label>
                    </td>
                </tr>
            </table>
        </fieldset>
        <div class="ButtonStyle">
            <input type="submit" value="書き込み">
            <input type="reset" value="リセット">
        </div>
    </form>
</div>

<footer>
    <p>© Kurosawa Hiroya</p>
</footer>
</body>

</html>