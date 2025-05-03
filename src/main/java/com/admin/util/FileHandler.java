package com.admin.util;

import com.admin.model.Booking;
import com.admin.model.User;
import java.io.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

public class FileHandler {
    private static final String BOOKINGS_FILE = "bookings.txt";
    private static final String USERS_FILE = "users.txt";
    private static final DateTimeFormatter formatter = DateTimeFormatter.ISO_LOCAL_DATE_TIME;

    // Booking operations
    public static void saveBooking(Booking booking) throws IOException {
        try (FileWriter fw = new FileWriter(BOOKINGS_FILE, true);
             BufferedWriter bw = new BufferedWriter(fw);
             PrintWriter out = new PrintWriter(bw)) {
            out.println(booking.toString());
        }
    }

    public static List<Booking> loadBookings() throws IOException {
        List<Booking> bookings = new ArrayList<>();
        File file = new File(BOOKINGS_FILE);
        if (!file.exists()) {
            file.createNewFile();
            return bookings;
        }

        try (BufferedReader br = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length == 7) {
                    Booking booking = new Booking(
                        parts[0], // bookingId
                        parts[1], // customerName
                        parts[2], // eventType
                        LocalDateTime.parse(parts[3], formatter), // eventDate
                        parts[4], // location
                        Double.parseDouble(parts[5]), // payment
                        parts[6]  // status
                    );
                    bookings.add(booking);
                }
            }
        }
        return bookings;
    }

    // User operations
    public static void saveUser(User user) throws IOException {
        try (FileWriter fw = new FileWriter(USERS_FILE, true);
             BufferedWriter bw = new BufferedWriter(fw);
             PrintWriter out = new PrintWriter(bw)) {
            out.println(user.toString());
        }
    }

    public static List<User> loadUsers() throws IOException {
        List<User> users = new ArrayList<>();
        File file = new File(USERS_FILE);
        if (!file.exists()) {
            file.createNewFile();
            return users;
        }

        try (BufferedReader br = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length == 5) {
                    User user = new User(
                        parts[0], // userId
                        parts[1], // username
                        parts[2], // email
                        parts[3], // role
                        parts[4]  // status
                    );
                    users.add(user);
                }
            }
        }
        return users;
    }

    // Report generation
    public static String generateReport() throws IOException {
        List<Booking> bookings = loadBookings();
        double totalEarnings = 0;
        int totalBookings = bookings.size();
        int completedBookings = 0;

        for (Booking booking : bookings) {
            totalEarnings += booking.calculateEarnings();
            if ("COMPLETED".equalsIgnoreCase(booking.getStatus())) {
                completedBookings++;
            }
        }

        return String.format("Total Bookings: %d\nCompleted Bookings: %d\nTotal Earnings: $%.2f",
                           totalBookings, completedBookings, totalEarnings);
    }
} 