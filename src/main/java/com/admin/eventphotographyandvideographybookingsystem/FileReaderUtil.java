package com.admin.eventphotographyandvideographybookingsystem;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;

public class FileReaderUtil {

    public static Admin getAdminCredentials(String filePath, String inputEmail, String inputPassword) throws IOException {
        try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
            String line;

            while ((line = reader.readLine()) != null) {
                String[] credentials = line.split(",");
                if (credentials.length == 7){
                    String fullName = credentials[0].trim();
                    String userName = credentials[1].trim();
                    String email = credentials[2].trim();
                    String gender = credentials[3].trim();
                    String phone = credentials[4].trim();
                    String address = credentials[5].trim();
                    String password = credentials[6].trim();

                    // Check if email and password match
                    if (email.equalsIgnoreCase(inputEmail) && password.equals(inputPassword)) {
                        return new Admin(fullName, userName, email, gender, phone, address, password);
                    }
                }
            }
        }
        return null; // Return null if no match is found
    }
}
