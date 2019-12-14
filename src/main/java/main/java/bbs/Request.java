package main.java.bbs;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;

public class Request extends HttpServlet {
    private static final String url = "jdbc:mysql://localhost:3306/bbs?UTF-8&serverTimezone=JST";
    private static final String user = "root";
    private static final String password = "password";

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

        request.setCharacterEncoding("UTF-8");
        String Type = request.getParameter("type");

        switch (Type) {
            case "insert":
                Insert(request, response);
                break;
            case "update":
                Update(request, response);
                break;
            case "delete":
                Delete(request, response);
                break;
            default:
                break;
        }
    }

    private void Insert(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        Connection conn = null;
        PreparedStatement ps = null;
        String sql = "INSERT INTO post values(?, ?, ?, ?, ?, ?)";

        try {
            conn = DriverManager.getConnection(url, user, password);

            ps = conn.prepareStatement(sql);
            ps.setNull(1, Types.INTEGER);
            ps.setString(2, request.getParameter("title"));
            ps.setString(3, request.getParameter("name"));
            ps.setString(4, request.getParameter("password"));
            ps.setTimestamp(5, new java.sql.Timestamp(new java.util.Date().getTime()));
            ps.setString(6, request.getParameter("message"));

            ps.executeUpdate();

        } catch (SQLException e) {
        } finally {
        }
    }

    private void Update(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        Connection conn = null;
        PreparedStatement ps = null;
        String sql = "UPDATE post SET title=?, name=?, message=? WHERE id=?;";

        try {
            conn = DriverManager.getConnection(url, user, password);

            ps = conn.prepareStatement(sql);
            ps.setString(1, request.getParameter("title"));
            ps.setString(2, request.getParameter("name"));
            ps.setString(3, request.getParameter("message"));
            ps.setString(4, request.getParameter("id"));

            ps.executeUpdate();

            response.sendRedirect("/bbs/finish.jsp");

        } catch (SQLException e) {
        } finally {
        }
    }

    private void Delete(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        Connection conn = null;
        PreparedStatement ps = null;
        String sql = "DELETE FROM post WHERE id = ?";
        final String[] Reshuffle = {"ALTER TABLE post drop column id;",
                "ALTER TABLE post add id int primary key not null auto_increment first;",
                "ALTER TABLE post AUTO_INCREMENT = 1;"};

        try {
            conn = DriverManager.getConnection(url, user, password);

            ps = conn.prepareStatement(sql);
            ps.setInt(1, Integer.parseInt(request.getParameter("id")));

            ps.executeUpdate();

            for (String string : Reshuffle) {
                ps = conn.prepareStatement(string);
                ps.executeUpdate();
            }

            response.sendRedirect("/bbs/finish.jsp");

        } catch (SQLException e) {
        } finally {
        }
    }
}