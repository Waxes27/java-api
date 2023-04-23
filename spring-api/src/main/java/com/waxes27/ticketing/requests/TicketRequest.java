package com.waxes27.ticketing.requests;

import com.waxes27.ticketing.enums.Category;

import java.util.Date;

public record TicketRequest(
        String issue,
        Category category,
        String author,
        String floor,
        String date
) {
}
