package io.github.shirohoo.realworld.application.user.request;

import com.fasterxml.jackson.annotation.JsonRootName;

@JsonRootName("user")
public record UpdateUserRequest(String email, String username, String password, String bio, String image) {}
