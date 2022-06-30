package com.standard.HelloStandardBE;

import com.azure.core.http.rest.PagedIterable;
import com.azure.storage.blob.BlobClient;
import com.azure.storage.blob.BlobContainerClient;
import com.azure.storage.blob.BlobServiceClient;
import com.azure.storage.blob.BlobServiceClientBuilder;
import com.azure.storage.blob.models.BlobItem;
import org.springframework.stereotype.Component;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

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

    @GET
    @Path("pics")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getPics() {
        BlobServiceClient blobServiceClient = new BlobServiceClientBuilder()
                .connectionString("Connection string goes here")
                .buildClient();

        BlobContainerClient bcc = blobServiceClient.getBlobContainerClient("weddingceremony");

        PagedIterable<BlobItem> pi = bcc.listBlobs();
        List<Pic> items = new ArrayList<>();
        for (BlobItem bi : pi.stream().collect(Collectors.toList())) {
            String n = bi.getName();
            BlobClient bc = bcc.getBlobClient(n);
            Pic pic = new Pic(bc.getBlobUrl());
            items.add(pic);
        }
        return Response.ok(items).build();
    }
}

class Pic {
    String path;
    public Pic(String path) {
        this.path = path;
    }

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }
}
