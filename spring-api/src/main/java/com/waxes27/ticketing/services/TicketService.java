package com.waxes27.ticketing.services;

import com.waxes27.ticketing.models.Status;
import com.waxes27.ticketing.models.Ticket;
import com.waxes27.ticketing.repository.TicketRepository;
import lombok.AllArgsConstructor;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
@AllArgsConstructor
public class TicketService {

    private final TicketRepository ticketRepository;

    public void createTicket(Ticket ticket){
        ticketRepository.save(ticket);
    }

    public List<JSONObject> getAllTickets(){
        List<JSONObject> ticketList = new ArrayList<>();
        List<Ticket> refTicketList = ticketRepository.findAll(Sort.by(Sort.Order.by("id")));
        for (Ticket ticket: refTicketList) {
            ticket.setReferenceId(String.valueOf(ticket.getId()));
            ticketList.add(new JSONObject(ticket.toString()));
        }

        return ticketList;
    }

    public void updateStatusOfTicket(String id, Status status) {
        Ticket ticket = ticketRepository.findById(Long.valueOf(id)).get();
        ticket.setCompleted(status);
        ticketRepository.save(ticket);
    }

    public List<Ticket> getTicketByUsername(String username) {
        return ticketRepository.findByUsername(username);
    }
}
