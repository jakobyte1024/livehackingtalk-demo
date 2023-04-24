package io.github.shirohoo.realworld.application.user.request;

import com.fasterxml.jackson.annotation.JsonRootName;

@JsonRootName("user")
public record LoginUserRequest(String email, String password) {}
