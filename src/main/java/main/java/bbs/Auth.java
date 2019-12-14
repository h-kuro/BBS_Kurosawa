package main.java.bbs;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;

public class Auth extends HttpServlet {

    private final String url = "jdbc:mysql://localhost:3306/bbs?UTF-8&serverTimezone=JST";
    private final String user = "root";
    private final String password = "password";

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String sql = "SELECT * FROM post WHERE id =" + request.getParameter("id");

        try {

            Connection conn = DriverManager.getConnection(url, user, password);
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);
            rs.next();

            request.setAttribute("auth",
                    Boolean.toString(request.getParameter("password").equals(rs.getString(4))));

            String path = "/" + request.getParameter("type") + ".jsp";
            RequestDispatcher dispatch = request.getRequestDispatcher(path);
            dispatch.forward(request, response);

        } catch (SQLException e) {

        } finally {
        }
    }

}
