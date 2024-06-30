<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import = "java.sql.*, javax.naming.*, javax.sql.DataSource" %>
<%
    String delName = request.getParameter("del_name");
    int delAge = Integer.parseInt(request.getParameter("del_age"));

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    boolean userExists = false;

    try {
        Context initContext = new InitialContext();
        Context envContext = (Context) initContext.lookup("java:/comp/env");
        DataSource ds = (DataSource) envContext.lookup("jdbc/MyDB");
        conn = ds.getConnection();

        String checkUserSQL = "SELECT COUNT(*) FROM user WHERE name = ? AND age = ?";
        pstmt = conn.prepareStatement(checkUserSQL);
        pstmt.setString(1, delName);
        pstmt.setInt(2, delAge);
        rs = pstmt.executeQuery();
        if (rs.next() && rs.getInt(1) > 0) {
            userExists = true;
        }

        if (userExists) {
            String deleteSQL = "DELETE FROM user WHERE name = ? AND age = ?";
            pstmt = conn.prepareStatement(deleteSQL);
            pstmt.setString(1, delName);
            pstmt.setInt(2, delAge);
            int rowsDeleted = pstmt.executeUpdate();

            if (rowsDeleted > 0) {
	        response.sendRedirect("/user");
            } else {
                out.println("<p>Error deleting user.</p>");
            }
        } else {
	    out.println("<p>User not found.</p>");
            out.println("<button onclick=\"history.back()\">Go Back</button>");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<p>Error occurred: " + e.getMessage() + "</p>");
	out.println("<button onclick=\"history.back()\">Go Back</button>");
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
        if (pstmt != null) try { pstmt.close(); } catch (SQLException ignore) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
    }
%>

