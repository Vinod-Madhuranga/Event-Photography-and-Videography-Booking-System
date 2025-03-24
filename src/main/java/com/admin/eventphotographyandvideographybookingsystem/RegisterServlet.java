package com.admin.eventphotographyandvideographybookingsystem;

import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.File;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class RegisterServlet extends HttpServlet {
    private static final String FILE_PATH = "E:/OneDrive - Sri Lanka Institute of Information Technology/Y1S2/OOP/Project/Admin Management/Event Photography and Videography Booking System/src/main/webapp/Database/admin_credentials.txt"; // Change this path as needed

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get form data
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Save user data to a file
        try (FileWriter fileWriter = new FileWriter(FILE_PATH, true);
             PrintWriter printWriter = new PrintWriter(fileWriter)) {
            printWriter.println(firstName + "," + lastName + "," + email + "," + password);
        } catch (IOException e) {
            e.printStackTrace();
        }

        // Redirect to login page with success message
        response.sendRedirect("login.jsp?success=registered");
    }

}
