<%@ page import="java.io.FileReader" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Manage Photographers</title>
</head>
<body>
<h2>Pending Photographer Approvals</h2>
<ul>
    <%
        BufferedReader br = new BufferedReader(new FileReader("E:/OneDrive - Sri Lanka Institute of Information Technology/Y1S2/OOP/Project/Admin Management/Event Photography and Videography Booking System/src/main/webapp/Database/users.txt"));
        String line;
        while ((line = br.readLine()) != null) {
            String[] data = line.split(",");
            if (data[2].equals("pending")) { // Check if status is 'pending'
    %>
    <li>
        <%= data[0] %> (Email: <%= data[1] %>)
        <form action="AdminServlet" method="post">
            <input type="hidden" name="username" value="<%= data[0] %>">
            <button type="submit" name="action" value="approve">Approve</button>
            <button type="submit" name="action" value="reject">Reject</button>
        </form>
    </li>
    <%
            }
        }
        br.close();
    %>
</ul>
</body>
</html>
