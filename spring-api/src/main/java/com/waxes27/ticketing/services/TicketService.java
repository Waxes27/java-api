package com.waxes27.ticketing.services;

import com.waxes27.ticketing.enums.Status;
import com.waxes27.ticketing.models.Ticket;
import com.waxes27.ticketing.repository.TicketRepository;
import lombok.AllArgsConstructor;
import org.json.JSONObject;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@AllArgsConstructor
public class TicketService {

    private final TicketRepository ticketRepository;

    public Ticket createTicket(Ticket ticket){
        return ticketRepository.save(ticket);
    }

    public List<Map<String,Object>> getAllTickets(String state) throws IllegalAccessException {
        List<Map<String,Object>> ticketList = new ArrayList<>();

        if (state != null && !state.isEmpty()){
            Status status = Status.valueOf(state.toUpperCase());
            Map map = new HashMap<>();
            List<Ticket> refTicketList = ticketRepository.findByCompleted(status);
            for (Ticket ticket: refTicketList) {
                ticket.setReferenceId(String.valueOf(ticket.getId()));
                ticketList.add(ticket.toMap());
            }
        }else {
            List<Ticket> refTicketList = ticketRepository.findAll();
            for (Ticket ticket: refTicketList) {
                ticket.setReferenceId(String.valueOf(ticket.getId()));
                ticketList.add(ticket.toMap());
            }
        }

        return ticketList;
    }

    public Ticket updateStatusOfTicket(String id, Status status) {
        Ticket ticket = ticketRepository.findById(Long.valueOf(id)).get();
        ticket.setCompleted(status);
        return ticketRepository.save(ticket);
    }

    public List<Ticket> getTicketByUsername(String username) {
        return ticketRepository.findByUsername(username);
    }

    public Ticket getTicketByID(Long id) throws IllegalAccessException {
        if(ticketRepository.findById(id).isEmpty()){
            throw new IllegalAccessException("Ticket by unknown ID");
        }else{
        return ticketRepository.findById(id).get();
    }}
}
