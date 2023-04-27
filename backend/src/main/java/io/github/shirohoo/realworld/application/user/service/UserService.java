package io.github.shirohoo.realworld.application.user.service;

import io.github.shirohoo.realworld.application.user.request.LoginUserRequest;
import io.github.shirohoo.realworld.application.user.request.SignUpUserRequest;
import io.github.shirohoo.realworld.application.user.request.UpdateUserRequest;
import io.github.shirohoo.realworld.domain.user.User;
import io.github.shirohoo.realworld.domain.user.UserRepository;
import io.github.shirohoo.realworld.domain.user.UserVO;

import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.server.ResponseStatusException;

import lombok.RequiredArgsConstructor;

import java.util.UUID;

@Service
@RequiredArgsConstructor
public class UserService {
    private final UserRepository userRepository;

    @Transactional
    public User signUp(SignUpUserRequest request) {
        this.validateUsernameAndEmail(request);
        User newUser = request.toUser();
        newUser.password(request.password());
        return userRepository.save(newUser);
    }

    private void validateUsernameAndEmail(SignUpUserRequest request) {
        String username = request.username();
        if (userRepository.existsByUsername(username)) {
            throw new IllegalArgumentException("Username(`%s`) already exists.".formatted(username));
        }

        String email = request.email();
        if (userRepository.existsByEmail(email)) {
            throw new IllegalArgumentException("Email(`%s`) already exists.".formatted(email));
        }
    }

    @Transactional(readOnly = true)
    public UserVO login(LoginUserRequest request) {
        return userRepository
                .findByEmail(request.email())
                .filter(user -> request.password().equals(user.password()))
                .map(user -> {
                    String token = "superToken";
                    return new UserVO(user.token(token));
                })
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Invalid user or password"));
    }

    @Transactional(readOnly = true)
    public UserVO findUser(UUID userId) {

        return userRepository
                .findById(userId)
                .filter(user -> userId.equals(userId))
                .map(user -> {
                    return new UserVO(user);
                })
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Unable to find resource"));
    }

    @Transactional
    public UserVO update(User user, UpdateUserRequest request) {
        this.updateEmail(user, request);
        this.updatePassword(user, request);
        this.updateUsername(user, request);
        this.updateUserDetails(user, request);
        return new UserVO(user);
    }

    private void updateEmail(User user, UpdateUserRequest request) {
        String email = request.email();
        if (email != null && !email.equals(user.email()) && userRepository.existsByEmail(email)) {
            throw new IllegalArgumentException("Email(`%s`) already exists.".formatted(email));
        }
        if (email != null && !email.isBlank()) {
            user.email(email);
        }
    }

    private void updatePassword(User user, UpdateUserRequest request) {
        String password = request.password();
        if (password != null && !password.isBlank()) {
            String encoded = password;
            user.password(encoded);
        }
    }

    private void updateUsername(User user, UpdateUserRequest request) {
        String username = request.username();
        if (username != null && !username.equals(user.username()) && userRepository.existsByUsername(username)) {
            throw new IllegalArgumentException("Username(`%s`) already exists.".formatted(username));
        }
        if (username != null && !username.isBlank()) {
            user.username(username);
        }
    }

    private void updateUserDetails(User user, UpdateUserRequest request) {
        user.bio(request.bio());
        user.image(request.image());
    }
}
