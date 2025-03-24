<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.FileReader" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Monitor Bookings & Payments</title>
</head>
<body>
<h2>All Bookings</h2>
<table border="1">
    <tr>
        <th>Booking ID</th>
        <th>Photographer</th>
        <th>Customer</th>
        <th>Amount</th>
        <th>Date</th>
    </tr>
    <%
        BufferedReader br = new BufferedReader(new FileReader("E:/OneDrive - Sri Lanka Institute of Information Technology/Y1S2/OOP/Project/Admin Management/Event Photography and Videography Booking System/src/main/webapp/Database/bookings.txt"));
        String line;
        while ((line = br.readLine()) != null) {
            String[] data = line.split(",");
    %>
    <tr>
        <td><%= data[0] %></td>
        <td><%= data[1] %></td>
        <td><%= data[2] %></td>
        <td>$<%= data[3] %></td>
        <td><%= data[4] %></td>
    </tr>
    <%
        }
        br.close();
    %>
</table>
</body>
</html>
