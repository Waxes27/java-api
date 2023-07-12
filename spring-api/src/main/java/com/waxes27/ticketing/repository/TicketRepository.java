package com.waxes27.ticketing.repository;

import com.waxes27.ticketing.enums.Status;
import com.waxes27.ticketing.models.Ticket;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@Repository
public interface TicketRepository extends JpaRepository<Ticket,Long> {
    List<Ticket> findByCompleted(Status completed);
    List<Ticket> findByUsername(String username);
}
