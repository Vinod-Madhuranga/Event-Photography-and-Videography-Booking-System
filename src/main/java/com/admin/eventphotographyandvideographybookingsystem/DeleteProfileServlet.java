package com.admin.eventphotographyandvideographybookingsystem;

import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/DeleteProfileServlet")
public class DeleteProfileServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("adminUser") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String userName = (String) session.getAttribute("userName");

        // Get the correct file path dynamically (NO CONCATENATION)
        String filePath = getServletContext().getRealPath("E:/OneDrive - Sri Lanka Institute of Information Technology/Y1S2/OOP/Project/Admin Management/Event Photography and Videography Booking System/src/main/webapp/Database/admin_credentials.txt");
        if (filePath == null || filePath.isEmpty()) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "File path is invalid.");
            return;
        }

        File file = new File(filePath);
        File tempFile = new File(file.getAbsolutePath() + ".tmp");

        // Check if the file exists before processing
        if (!file.exists()) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Admin credentials file not found.");
            return;
        }

        boolean isDeleted = false;

        try (BufferedReader reader = new BufferedReader(new FileReader(file));
             PrintWriter writer = new PrintWriter(new FileWriter(tempFile))) {

            String line;
            while ((line = reader.readLine()) != null) {
                String[] userData = line.split(",");
                if (userData.length > 1 && userData[1].equals(userName)) {
                    isDeleted = true; // Mark that the profile was found and deleted
                    continue; // Skip writing this line to remove the profile
                }
                writer.println(line);
            }
        }

        // If user was found and deleted, update the file
        if (isDeleted) {
            if (file.delete() && tempFile.renameTo(file)) {
                session.invalidate(); // End the session
                response.sendRedirect("login.jsp");
            } else {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to delete profile.");
            }
        } else {
            // If no matching user was found, delete the temp file and send an error response
            tempFile.delete();
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "User profile not found.");
        }
    }
}
