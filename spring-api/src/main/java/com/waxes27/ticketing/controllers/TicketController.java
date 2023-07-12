package com.waxes27.ticketing.controllers;

import com.waxes27.ticketing.enums.Category;
import com.waxes27.ticketing.enums.Status;
import com.waxes27.ticketing.models.Ticket;
import com.waxes27.ticketing.requests.TicketRequest;
import com.waxes27.ticketing.services.TicketService;
import lombok.AllArgsConstructor;
import org.json.JSONObject;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.websocket.server.PathParam;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/tickets")
@AllArgsConstructor
public class TicketController {
    private final TicketService service;

    @PostMapping()
    public ResponseEntity<Ticket> createTicket(@RequestBody TicketRequest ticketRequest){
        return new ResponseEntity<Ticket>(service.createTicket(new Ticket(
                        LocalDateTime.now().toString(),
                        ticketRequest.author(),
                        ticketRequest.issue(),
                        ticketRequest.floor(),
                        LocalDateTime.now().toString(),
                        "JHB",
                        Status.INCOMPLETE,
                        ticketRequest.category()
                )), HttpStatus.ACCEPTED);
    }

    @GetMapping
    public ResponseEntity<List<Map<String,Object>>> getAllTickets(@PathParam("state") String state) throws IllegalAccessException {

        return new ResponseEntity<List<Map<String,Object>>>(service.getAllTickets(state),HttpStatus.OK);
    }

    @GetMapping("{id}")
    public ResponseEntity<Ticket> getTicketByID(@PathParam("id") Long id) throws IllegalAccessException {

        return new ResponseEntity<Ticket>(service.getTicketByID(id),HttpStatus.OK);
    }

    @PostMapping("/update/{id}/{status}")
    public ResponseEntity<Ticket> updateTicketStatusById(@PathVariable("id") String id, @PathVariable String status){
        return new ResponseEntity<Ticket>(service.updateStatusOfTicket(id, Status.valueOf(status.toUpperCase())),HttpStatus.ACCEPTED);
    }

    @DeleteMapping
    public void deleteTicket(){

    }

    @GetMapping("{username}")
    public List<Ticket> getTicketsByUserName(@PathVariable("username") String username){
        return service.getTicketByUsername(username);
    }
}
