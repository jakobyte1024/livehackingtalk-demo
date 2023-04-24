package io.github.shirohoo.realworld.domain.article;

import io.github.shirohoo.realworld.domain.user.User;

import java.time.LocalDateTime;
import java.util.HashSet;
import java.util.Objects;
import java.util.Set;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EntityListeners;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.JoinTable;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.ManyToOne;

import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.Accessors;

@Entity
@Getter
@Setter
@NoArgsConstructor
@Accessors(fluent = true, chain = true)
@EntityListeners(AuditingEntityListener.class)
public class Article {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne(fetch = FetchType.LAZY)
    private User author;

    @Column(unique = true)
    private String slug;

    @Column(unique = true)
    private String title;

    private String description;

    private String content;

    @ManyToMany(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    @JoinTable(
            name = "article_favorites",
            joinColumns = @JoinColumn(name = "article_id"),
            inverseJoinColumns = @JoinColumn(name = "user_id"))
    private Set<User> favorites = new HashSet<>();

    @ManyToMany(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    @JoinTable(
            name = "article_tags",
            joinColumns = @JoinColumn(name = "article_id"),
            inverseJoinColumns = @JoinColumn(name = "tag_id"))
    private Set<Tag> tags = new HashSet<>();

    @CreatedDate
    private LocalDateTime createdAt;

    @LastModifiedDate
    private LocalDateTime updatedAt;

    @Builder
    public Article(
            Integer id,
            User author,
            String title,
            String description,
            String content,
            Set<User> favorites,
            Set<Tag> tags,
            LocalDateTime createdAt,
            LocalDateTime updatedAt) {
        this.id = id;
        this.author = author;
        this.slug = title.toLowerCase().replaceAll("\\s+", "-");
        this.title = title;
        this.description = description;
        this.content = content;
        this.favorites = favorites == null ? new HashSet<>() : favorites;
        this.tags = tags == null ? new HashSet<>() : tags;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    public Article update(User author, String title, String description, String content) {
        if (!this.isAuthoredBy(author))
            throw new IllegalArgumentException("You cannot edit articles written by others.");
        if (title != null && !title.isBlank()) this.title(title);
        if (description != null && !description.isBlank()) this.description = description;
        if (content != null && !content.isBlank()) this.content = content;
        return this;
    }

    public Article title(String title) {
        this.slug = title.toLowerCase().replaceAll("\\s+", "-");
        this.title = title;
        return this;
    }

    public Article addTag(Tag tag) {
        if (this.tags.contains(tag)) return this;
        this.tags.add(tag);
        tag.addTag(this);
        return this;
    }

    public Article favoritedBy(User user) {
        if (this.favorites.contains(user)) return this;
        this.favorites.add(user);
        user.favorite(this);
        return this;
    }

    public Article unfavoritedBy(User user) {
        if (!this.favorites.contains(user)) return this;
        this.favorites.remove(user);
        user.unfavorite(this);
        return this;
    }

    public boolean hasFavorited(User user) {
        return this.favorites.contains(user);
    }

    public boolean isAuthoredBy(User user) {
        return this.author.equals(user);
    }

    public boolean isTaggedBy(Tag tag) {
        return this.tags.contains(tag);
    }

    public int favoritesCount() {
        return this.favorites.size();
    }

    public String[] tags() {
        return this.tags.stream().map(Tag::name).sorted().toArray(String[]::new);
    }

    public Set<User> favorites() {
        return Set.copyOf(this.favorites);
    }

    @Override
    public boolean equals(Object o) {
        return o instanceof Article other && Objects.equals(this.id, other.id);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }
}
