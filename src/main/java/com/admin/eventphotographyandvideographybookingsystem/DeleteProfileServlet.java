package com.admin.eventphotographyandvideographybookingsystem;

import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/DeleteProfileServlet")
public class DeleteProfileServlet extends HttpServlet {
    private static final String CREDENTIALS_FILE_PATH = "E:/OneDrive - Sri Lanka Institute of Information Technology/Y1S2/OOP/Project/Admin Management/Event Photography and Videography Booking System/src/main/webapp/Database/admin_credentials.txt";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response); // Delegate to doPost for simplicity
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("adminUser") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String userName = (String) session.getAttribute("userName");
        if (userName == null || userName.trim().isEmpty()) {
            response.sendRedirect("login.jsp");
            return;
        }

        String filePath = getServletContext().getRealPath(CREDENTIALS_FILE_PATH);
        File file = new File(filePath);
        File tempFile = new File(file.getAbsolutePath() + ".tmp");
        boolean isDeleted = false;
        String errorMessage = null;

        if (!file.exists()) {
            errorMessage = "Admin credentials file not found.";
        } else {
            try (BufferedReader reader = new BufferedReader(new FileReader(file));
                 PrintWriter writer = new PrintWriter(new FileWriter(tempFile))) {

                String line;
                while ((line = reader.readLine()) != null) {
                    String[] userData = line.split(",");
                    if (userData.length > 1 && userData[1].trim().equals(userName.trim())) {
                        isDeleted = true;
                        continue;
                    }
                    writer.println(line);
                }
            } catch (Exception e) {
                errorMessage = "Error processing file: " + e.getMessage();
            }

            if (isDeleted) {
                try {
                    if (file.delete() && tempFile.renameTo(file)) {
                        session.invalidate();
                    } else {
                        errorMessage = "Failed to update credentials file.";
                    }
                } catch (Exception e) {
                    errorMessage = "Error updating file: " + e.getMessage();
                }
            } else {
                tempFile.delete();
                errorMessage = "User profile not found in credentials file.";
            }
        }

        // Redirect to a result page with a parameter indicating success or failure
        if (isDeleted && errorMessage == null) {
            response.sendRedirect("deleteResult.jsp?status=success");
        } else {
            response.sendRedirect("deleteResult.jsp?status=error&message=" +
                    java.net.URLEncoder.encode(errorMessage != null ? errorMessage : "Failed to delete profile.", "UTF-8"));
        }
    }
}