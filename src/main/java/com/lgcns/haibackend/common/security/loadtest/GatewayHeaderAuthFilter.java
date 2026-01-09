package com.lgcns.haibackend.common.security.loadtest;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.context.annotation.Profile;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;
import java.util.List;

@Component
@Profile({"local", "loadtest"})
public class GatewayHeaderAuthFilter extends OncePerRequestFilter {

    @Override
    protected void doFilterInternal(HttpServletRequest request,
                                    HttpServletResponse response,
                                    FilterChain filterChain)
            throws ServletException, IOException {

        var ctx = SecurityContextHolder.getContext();
        if (ctx.getAuthentication() == null) {
            String userId = request.getHeader("X-User-Id");
            String nickname = request.getHeader("X-User-Nickname");
            String role = request.getHeader("X-User-Role");

            if (userId == null || userId.isBlank()) userId = "loadtest-user";
            if (nickname == null) nickname = "";
            if (role == null || role.isBlank()) role = "ROLE_USER";

            var principal = new LoadtestPrincipal(userId, nickname, role);
            var authorities = List.of(new SimpleGrantedAuthority(role));

            var auth = new UsernamePasswordAuthenticationToken(principal, null, authorities);
            ctx.setAuthentication(auth);
        }

        filterChain.doFilter(request, response);
    }
}
