package com.lgcns.haibackend.user.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.lgcns.haibackend.user.domain.dto.UserRequestDTO;
import com.lgcns.haibackend.user.domain.dto.UserResponseDTO;
import com.lgcns.haibackend.user.domain.entity.UserEntity;
import com.lgcns.haibackend.user.repository.UserRepository;
import com.lgcns.haibackend.user.service.UserService;

import java.nio.file.attribute.UserPrincipal;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

@RestController
@RequestMapping("/api/user")
public class UserController {
    @Autowired
    private UserService userService;

    @PostMapping("/signup")
    public ResponseEntity<UserResponseDTO> signup(@RequestBody UserRequestDTO request, BindingResult bindingResult) {
        System.out.println(">>>> user ctrl POST /signup");
        System.out.println(">>>> user ctrl POST /signup param : " + request);

        if (bindingResult.hasErrors()) {
            Map<String, String> errorMap = new HashMap<>();
            bindingResult.getAllErrors().forEach(err -> {
                FieldError filed = (FieldError) err;
                String msg = err.getDefaultMessage();

                System.out.println("[debug] >>> validation err: " + filed.getField() + " - " + msg);
                errorMap.put(filed.getField(), msg);
            });
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
        }

        UserResponseDTO response = userService.signup(request);
        if (response != null) {
            return ResponseEntity.status(HttpStatus.NO_CONTENT).body(null);
        } else {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }
    }

    @PostMapping("/login")
    public ResponseEntity<UserResponseDTO> login(@RequestBody UserRequestDTO request) {
        System.out.println(">>>> user ctrl POST /signin");
        System.out.println(">>>> user ctrl POST /signin param: " + request);
        Map<String, Object> map = userService.login(request);

        return ResponseEntity.status(HttpStatus.OK)
                .header("Authorization", "Bearer " + (String) map.get("access"))
                .header("Refresh-Token", (String) (map.get("refresh")))
                .body((UserResponseDTO) map.get("response"));
    }

    
}
