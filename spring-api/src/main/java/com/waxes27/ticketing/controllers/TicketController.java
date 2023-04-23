package com.waxes27.ticketing.controllers;

import com.waxes27.ticketing.enums.Category;
import com.waxes27.ticketing.models.Status;
import com.waxes27.ticketing.models.Ticket;
import com.waxes27.ticketing.requests.TicketRequest;
import com.waxes27.ticketing.services.TicketService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;

@RestController
@RequestMapping("/tickets")
@CrossOrigin
@AllArgsConstructor
public class TicketController {
    private final TicketService service;

    @PostMapping
    public void createTicket(@RequestBody TicketRequest ticketRequest){
        service.createTicket(new Ticket(
                LocalDateTime.now().toString(),
                ticketRequest.author(),
                ticketRequest.issue(),
                ticketRequest.floor(),
                LocalDateTime.now().toString(),
                "JHB",
                Status.INCOMPLETE,
                Category.HARDWARE
        ));
    }

    @GetMapping
    public Object getAllTickets(){
        return service.getAllTickets().toString();
    }

    @PostMapping("/update/{id}/{status}")
    public void updateTicketStatusById(@PathVariable("id") String id, @PathVariable String status){
        service.updateStatusOfTicket(id, Status.valueOf(status.toUpperCase()));
    }

    @DeleteMapping
    public void deleteTicket(){

    }
}
