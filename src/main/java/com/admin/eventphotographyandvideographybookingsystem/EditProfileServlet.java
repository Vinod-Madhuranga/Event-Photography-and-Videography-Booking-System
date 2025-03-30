package com.admin.eventphotographyandvideographybookingsystem;

import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.File;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/EditProfileServlet")
public class EditProfileServlet extends HttpServlet {
    private static final String FILE_PATH = "E:/OneDrive - Sri Lanka Institute of Information Technology/Y1S2/OOP/Project/Admin Management/Event Photography and Videography Booking System/src/main/webapp/Database/admin_credentials.txt";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("adminUser") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String oldUsername = (String) session.getAttribute("userName");
        String fullName = request.getParameter("fullName");
        String userName = request.getParameter("userName");
        String email = request.getParameter("email");
        String gender = request.getParameter("gender");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String password = request.getParameter("password");

        String filePath = getServletContext().getRealPath("/") + FILE_PATH;
        File file = new File(filePath);
        File tempFile = new File(file.getAbsolutePath() + ".tmp");

        BufferedReader reader = new BufferedReader(new FileReader(file));
        PrintWriter writer = new PrintWriter(new FileWriter(tempFile));
        String line;

        while ((line = reader.readLine()) != null) {
            String[] userData = line.split(",");
            if (userData[1].equals(oldUsername)) {
                // Update the matching record
                writer.println(fullName + "," + userName + "," + email + "," + gender + "," + phone + "," + address + "," + password);
            } else {
                writer.println(line);
            }
        }

        reader.close();
        writer.close();

        // Replace the old file with the updated file
        if (file.delete() && tempFile.renameTo(file)) {
            // Update session attributes
            session.setAttribute("fullName", fullName);
            session.setAttribute("email", email);
            session.setAttribute("gender", gender);
            session.setAttribute("phone", phone);
            session.setAttribute("address", address);
            session.setAttribute("password", password);
            response.sendRedirect("profile.jsp");
        } else {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to update profile.");
        }
    }
}