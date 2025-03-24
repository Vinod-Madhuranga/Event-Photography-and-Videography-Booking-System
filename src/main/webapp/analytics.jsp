<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Admin Analytics</title>
</head>
<body>
<h2>Analytics Dashboard</h2>
<h3>Top-Rated Photographers</h3>
<ul>
    <%
        // Simulating Top Photographers
        String[] photographers = { "John Doe", "Emily Smith", "Michael Brown" };
        for (String p : photographers) {
    %>
    <li><%= p %></li>
    <% } %>
</ul>

<h3>Most Booked Services</h3>
<ul>
    <%
        // Simulating Most Booked Services
        String[] services = { "Wedding Photography", "Event Videography", "Portrait Shoots" };
        for (String s : services) {
    %>
    <li><%= s %></li>
    <% } %>
</ul>
</body>
</html>
