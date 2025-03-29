package com.admin.eventphotographyandvideographybookingsystem;

import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/DeleteProfileServlet")
public class DeleteProfileServlet extends HttpServlet {
    private static final String FILE_PATH = "E:/OneDrive - Sri Lanka Institute of Information Technology/Y1S2/OOP/Project/Admin Management/Event Photography and Videography Booking System/src/main/webapp/Database/admin_credentials.txt";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("adminUser") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String userName = (String) session.getAttribute("userName");
        String filePath = getServletContext().getRealPath("/") + FILE_PATH;
        File file = new File(filePath);
        File tempFile = new File(file.getAbsolutePath() + ".tmp");

        BufferedReader reader = new BufferedReader(new FileReader(file));
        PrintWriter writer = new PrintWriter(new FileWriter(tempFile));
        String line;

        while ((line = reader.readLine()) != null) {
            String[] userData = line.split(",");
            if (!userData[1].equals(userName)) {
                writer.println(line);
            }
        }

        reader.close();
        writer.close();

        if (file.delete() && tempFile.renameTo(file)) {
            session.invalidate(); // End the session
            response.sendRedirect("login.jsp");
        } else {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to delete profile.");
        }
    }
}