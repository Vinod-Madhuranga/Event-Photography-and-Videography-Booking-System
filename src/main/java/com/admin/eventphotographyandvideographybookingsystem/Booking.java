package com.admin.eventphotographyandvideographybookingsystem;

public class Booking {
    private String bookingId;
    private String customerId;
    private String photographerId;
    private String eventDate;

    public Booking(String bookingId, String customerId, String photographerId, String eventDate) {
        this.bookingId = bookingId;
        this.customerId = customerId;
        this.photographerId = photographerId;
        this.eventDate = eventDate;
    }

    public String getBookingId() { return bookingId; }
    public String getCustomerId() { return customerId; }
    public String getPhotographerId() { return photographerId; }
    public String getEventDate() { return eventDate; }
}
