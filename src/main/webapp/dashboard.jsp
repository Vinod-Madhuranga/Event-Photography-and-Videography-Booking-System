<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="com.admin.util.FileHandler" %>
<%@ page import="com.admin.model.Booking" %>
<%@ page import="com.admin.model.User" %>
<%@ page import="java.util.List" %>
<%@ page import="java.io.IOException" %>
<%
  HttpSession sessionObj = request.getSession(false);
  if (sessionObj == null || sessionObj.getAttribute("adminUser") == null) {
    response.sendRedirect("login.jsp");
    return; // Stop further execution
  }

  // Get the admin's name from the session
  String userName = (String) sessionObj.getAttribute("userName");
  
  // Load data for dashboard
  List<Booking> bookings = null;
  List<User> users = null;
  String totalEarnings = "$0.00";
  int totalBookings = 0;
  int completedBookings = 0;
  int activeUsers = 0;
  
  try {
    bookings = FileHandler.loadBookings();
    users = FileHandler.loadUsers();
    
    // Calculate statistics
    totalBookings = bookings.size();
    for (Booking booking : bookings) {
      if ("COMPLETED".equalsIgnoreCase(booking.getStatus())) {
        completedBookings++;
      }
    }
    
    for (User user : users) {
      if ("ACTIVE".equalsIgnoreCase(user.getStatus())) {
        activeUsers++;
      }
    }
    
    // Get total earnings from report
    String report = FileHandler.generateReport();
    String[] lines = report.split("\n");
    if (lines.length >= 3) {
      totalEarnings = lines[2].split(":")[1].trim();
    }
  } catch (IOException e) {
    // Handle error silently for dashboard
  }
%>

<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="Admin Dashboard for Event Photography and Videography Booking System">
  <meta name="author" content="Vinod Madhuranga">


  <title>Admin Dashboard</title>

  <!-- Fonts -->
  <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

  <!-- Custom styles -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
  <link href="css/admin.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet" >


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
      <li class="nav-item active">
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
      <li class="nav-item">
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
          <!-- Page Heading -->
          <div class="d-sm-flex align-items-center justify-content-between mb-4">
            <h1 class="h3 mb-0 text-gray-800">Dashboard</h1>
            <a href="reports.jsp" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm">
              <i class="fas fa-download fa-sm text-white-50"></i> Generate Report
            </a>
          </div>

          <!-- Content Row -->
          <div class="row">
            <!-- Earnings Card -->
            <div class="col-xl-3 col-md-6 mb-4">
              <div class="card border-left-primary shadow h-100 py-2">
                <div class="card-body">
                  <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                        Total Earnings (20%)</div>
                      <div class="h5 mb-0 font-weight-bold text-gray-800"><%= totalEarnings %></div>
                    </div>
                    <div class="col-auto">
                      <i class="fas fa-dollar-sign fa-2x text-gray-300"></i>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <!-- Total Bookings Card -->
            <div class="col-xl-3 col-md-6 mb-4">
              <div class="card border-left-success shadow h-100 py-2">
                <div class="card-body">
                  <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-success text-uppercase mb-1">
                        Total Bookings</div>
                      <div class="h5 mb-0 font-weight-bold text-gray-800"><%= totalBookings %></div>
                    </div>
                    <div class="col-auto">
                      <i class="fas fa-calendar fa-2x text-gray-300"></i>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <!-- Completed Bookings Card -->
            <div class="col-xl-3 col-md-6 mb-4">
              <div class="card border-left-info shadow h-100 py-2">
                <div class="card-body">
                  <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-info text-uppercase mb-1">
                        Completed Bookings</div>
                      <div class="h5 mb-0 font-weight-bold text-gray-800"><%= completedBookings %></div>
                    </div>
                    <div class="col-auto">
                      <i class="fas fa-check-circle fa-2x text-gray-300"></i>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <!-- Active Users Card -->
            <div class="col-xl-3 col-md-6 mb-4">
              <div class="card border-left-warning shadow h-100 py-2">
                <div class="card-body">
                  <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">
                        Active Users</div>
                      <div class="h5 mb-0 font-weight-bold text-gray-800"><%= activeUsers %></div>
                    </div>
                    <div class="col-auto">
                      <i class="fas fa-users fa-2x text-gray-300"></i>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <!-- Content Row -->
          <div class="row">
            <!-- Recent Bookings -->
            <div class="col-xl-8 col-lg-7">
              <div class="card shadow mb-4">
                <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                  <h6 class="m-0 font-weight-bold text-primary">Recent Bookings</h6>
                  <a href="bookings.jsp" class="btn btn-sm btn-primary">View All</a>
                </div>
                <div class="card-body">
                  <div class="table-responsive">
                    <table class="table table-bordered" width="100%" cellspacing="0">
                      <thead>
                        <tr>
                          <th>ID</th>
                          <th>Customer</th>
                          <th>Event Type</th>
                          <th>Date</th>
                          <th>Status</th>
                        </tr>
                      </thead>
                      <tbody>
                        <% if (bookings != null && !bookings.isEmpty()) {
                          for (int i = 0; i < Math.min(5, bookings.size()); i++) {
                            Booking booking = bookings.get(i);
                        %>
                        <tr>
                          <td><%= booking.getBookingId() %></td>
                          <td><%= booking.getCustomerName() %></td>
                          <td><%= booking.getEventType() %></td>
                          <td><%= booking.getEventDate().toString() %></td>
                          <td>
                            <span class="badge <%= booking.getStatus().equals("COMPLETED") ? "bg-success" : 
                                               booking.getStatus().equals("PENDING") ? "bg-warning" : "bg-info" %>">
                              <%= booking.getStatus() %>
                            </span>
                          </td>
                        </tr>
                        <% }
                           } else { %>
                        <tr>
                          <td colspan="5" class="text-center">No bookings found</td>
                        </tr>
                        <% } %>
                      </tbody>
                    </table>
                  </div>
                </div>
              </div>
            </div>

            <!-- User Activity -->
            <div class="col-xl-4 col-lg-5">
              <div class="card shadow mb-4">
                <div class="card-header py-3">
                  <h6 class="m-0 font-weight-bold text-primary">User Activity</h6>
                </div>
                <div class="card-body">
                  <div class="table-responsive">
                    <table class="table table-bordered" width="100%" cellspacing="0">
                      <thead>
                        <tr>
                          <th>User</th>
                          <th>Status</th>
                        </tr>
                      </thead>
                      <tbody>
                        <% if (users != null && !users.isEmpty()) {
                          for (int i = 0; i < Math.min(5, users.size()); i++) {
                            User user = users.get(i);
                        %>
                        <tr>
                          <td><%= user.getUsername() %></td>
                          <td>
                            <span class="badge <%= user.getStatus().equals("ACTIVE") ? "bg-success" : 
                                               user.getStatus().equals("SUSPENDED") ? "bg-warning" : "bg-danger" %>">
                              <%= user.getStatus() %>
                            </span>
                          </td>
                        </tr>
                        <% }
                           } else { %>
                        <tr>
                          <td colspan="2" class="text-center">No users found</td>
                        </tr>
                        <% } %>
                      </tbody>
                    </table>
                  </div>
                </div>
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
</body>

</html>
