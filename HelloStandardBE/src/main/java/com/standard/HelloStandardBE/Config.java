package com.standard.HelloStandardBE;

import org.glassfish.jersey.server.ResourceConfig;
import org.springframework.context.annotation.Configuration;


@Configuration
public class Config extends ResourceConfig {

    public Config() {
        register(Text.class);
        register(Filter.class);
    }
}
