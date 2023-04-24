package io.github.shirohoo.realworld.application.article.request;

import com.fasterxml.jackson.annotation.JsonRootName;

@JsonRootName("comment")
public record CreateCommentRequest(String body) {}
