package com.standard.HelloStandardBE;

import org.springframework.stereotype.Component;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

@Component
@Path("text")
public class Text {

    @GET
    @Produces(MediaType.TEXT_PLAIN)
    public Response get() {
        String[] items = new String[]{"Hello Standard", "Hello from springboot", "Hello from docker", "Hello from java", "Hello angular"};
        int i = (int) Math.floor(Math.random() * 5);
        String group = items[i];
        System.out.println("Fetched target group: " + group);
        return Response.ok().entity(group).build();
    }
}
