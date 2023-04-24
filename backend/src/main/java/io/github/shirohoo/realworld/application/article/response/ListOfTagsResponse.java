package io.github.shirohoo.realworld.application.article.response;

import java.util.List;

public record ListOfTagsResponse(String[] tags) {
    public ListOfTagsResponse(List<String> tags) {
        this(tags.toArray(String[]::new));
    }
}
