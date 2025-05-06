<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="com.admin.model.Booking" %>
<%@ page import="java.util.List" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%
  HttpSession sessionObj = request.getSession(false);
  if (sessionObj == null || sessionObj.getAttribute("adminUser") == null) {
    response.sendRedirect("login.jsp");
    return;
  }

  String userName = (String) sessionObj.getAttribute("userName");
  List<Booking> bookings = (List<Booking>) request.getAttribute("bookings");
  if (bookings == null) {
    response.sendRedirect("BookingServlet?action=list");
    return;
  }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>View All Bookings</title>
    <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="css/admin.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">
</head>

<body id="page-top">
    <!-- Page Wrapper -->
    <div id="wrapper">
        <!-- Sidebar -->
        <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion toggled" id="accordionSidebar">
            <!-- Sidebar - Brand -->
            <div class="sidebar-brand d-flex align-items-center justify-content-center">
                <div class="sidebar-brand-icon rotate-n-15">
                    <i class="fa-solid fa-camera"></i>
                </div>
            </div>

            <!-- Divider -->
            <hr class="sidebar-divider my-0">

            <!-- Divider -->
            <hr class="sidebar-divider">

            <!-- Heading -->
            <div class="sidebar-heading">
                Interface
            </div>

            <!-- Nav Item - Dashboard -->
            <li class="nav-item">
                <a class="nav-link" href="dashboard.jsp">
                    <i class="fas fa-fw fa-tachometer-alt"></i>
                    <span>Dashboard</span>
                </a>
            </li>

            <!-- Nav Item - Profile -->
            <li class="nav-item">
                <a class="nav-link collapsed" href="profile.jsp">
                    <i class="fas fa-fw fa-user"></i>
                    <span>Profile</span>
                </a>
            </li>

            <!-- Divider -->
            <hr class="sidebar-divider">

            <!-- Heading -->
            <div class="sidebar-heading">
                Management
            </div>

            <!-- Nav Item - Bookings -->
            <li class="nav-item active">
                <a class="nav-link" href="bookings.jsp">
                    <i class="fas fa-fw fa-calendar"></i>
                    <span>View All Bookings</span>
                </a>
            </li>

            <!-- Nav Item - Users -->
            <li class="nav-item">
                <a class="nav-link" href="users.jsp">
                    <i class="fas fa-fw fa-users"></i>
                    <span>Manage <br>Users</span>
                </a>
            </li>

            <!-- Divider -->
            <hr class="sidebar-divider">

            <!-- Heading -->
            <div class="sidebar-heading">
                Analytics
            </div>

            <!-- Nav Item - Analytics -->
            <li class="nav-item">
                <a class="nav-link" href="analytics.jsp">
                    <i class="fas fa-fw fa-chart-line"></i>
                    <span>Analytics</span>
                </a>
            </li>

            <!-- Divider -->
            <hr class="sidebar-divider d-none d-md-block">
        </ul>
        <!-- End of Sidebar -->

        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">
            <!-- Main Content -->
            <div id="content">
                <!-- Topbar -->
                <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">
                    <!-- Sidebar Toggle (Topbar) -->
                    <button id="sidebarToggleTop" class="btn btn-link rounded-circle mr-3">
                        <i class="fa fa-bars"></i>
                    </button>

                    <!-- Topbar Navbar -->
                    <ul class="navbar-nav ml-auto">
                        <div class="topbar-divider d-none d-sm-block"></div>

                        <!-- Nav Item - User Information -->
                        <li class="nav-item dropdown no-arrow">
                            <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button"
                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <span class="mr-2 d-none d-lg-inline text-gray-600 small"><%= (userName != null) ? userName : "Admin" %></span>
                                <img class="img-profile rounded-circle" src="img/undraw_profile.svg">
                            </a>
                            <!-- Dropdown - User Information -->
                            <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="userDropdown">
                                <a class="dropdown-item" href="profile.jsp">
                                    <i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>
                                    Profile
                                </a>
                                <div class="dropdown-divider"></div>
                                <a class="dropdown-item" href="LogoutServlet?action=logout">
                                    <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
                                    Logout
                                </a>
                            </div>
                        </li>
                    </ul>
                </nav>
                <!-- End of Topbar -->

                <!-- Begin Page Content -->
                <div class="container-fluid">
                    <h1 class="h3 mb-4 text-gray-800">View All Bookings</h1>
                    
                    <!-- Bookings Table -->
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">All Bookings</h6>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="bookingsTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th>Booking ID</th>
                                            <th>Customer Name</th>
                                            <th>Event Type</th>
                                            <th>Event Date</th>
                                            <th>Location</th>
                                            <th>Payment</th>
                                            <th>Status</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% for (Booking booking : bookings) { %>
                                        <tr>
                                            <td><%= booking.getBookingId() %></td>
                                            <td><%= booking.getCustomerName() %></td>
                                            <td><%= booking.getEventType() %></td>
                                            <td><%= booking.getEventDate().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm")) %></td>
                                            <td><%= booking.getLocation() %></td>
                                            <td>$<%= String.format("%.2f", booking.getPayment()) %></td>
                                            <td><%= booking.getStatus() %></td>
                                            <td>
                                                <form action="BookingServlet" method="post" style="display: inline;">
                                                    <input type="hidden" name="action" value="update">
                                                    <input type="hidden" name="bookingId" value="<%= booking.getBookingId() %>">
                                                    <select name="status" class="form-control" onchange="this.form.submit()">
                                                        <option value="PENDING" <%= "PENDING".equals(booking.getStatus()) ? "selected" : "" %>>Pending</option>
                                                        <option value="CONFIRMED" <%= "CONFIRMED".equals(booking.getStatus()) ? "selected" : "" %>>Confirmed</option>
                                                        <option value="COMPLETED" <%= "COMPLETED".equals(booking.getStatus()) ? "selected" : "" %>>Completed</option>
                                                        <option value="CANCELLED" <%= "CANCELLED".equals(booking.getStatus()) ? "selected" : "" %>>Cancelled</option>
                                                    </select>
                                                </form>
                                            </td>
                                        </tr>
                                        <% } %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- End Page Content -->
            </div>
            <!-- End of Main Content -->
        </div>
        <!-- End of Content Wrapper -->
    </div>
    <!-- End of Page Wrapper -->

    <!-- Scripts -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="js/admin.min.js"></script>
    <script>
        $(document).ready(function() {
            $('#bookingsTable').DataTable();
        });
    </script>
</body>
</html>
