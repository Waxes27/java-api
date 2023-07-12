package com.waxes27.ticketing.controllers;

import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.websocket.server.PathParam;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/category")
@AllArgsConstructor
public class CategoryController {
    @GetMapping()
    public Map<String,String> getCategoryDescription(@PathParam("name") String name){
        Map<String,String> map = new HashMap<>();
        map.put("name",name);
        map.put("description",getDescription(name));
        return map;
    }

    private String getDescription(String name) {
        String description = "";
        switch (name){
            case "electrical":
                description = "Plugs, Light sockets etc.";
                break;
            case "plumbing":
                description = "Toilet, Basin, sink etc.";
                break;
            case "misc":
                description = "Windows, Doors Wardrobe etc.";
                break;
        }

        return description;
    }
}
