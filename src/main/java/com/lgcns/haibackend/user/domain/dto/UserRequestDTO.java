package com.lgcns.haibackend.user.domain.dto;

import java.util.UUID;

import com.lgcns.haibackend.global.Role;
import com.lgcns.haibackend.user.domain.entity.UserEntity;

import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class UserRequestDTO {
    @NotBlank(message = "사용자 이름은 필수입니다.")
    private String name;

    @NotBlank(message = "비밀번호는 필수입니다.")
    private String password;

    @NotBlank(message = "닉네임은 필수입니다.")
    private String nickname;

    @NotBlank(message = "역할(Role)은 필수입니다.")
    private Role role;

    // 학생 전용 필드 (Role이 STUDENT일 때 필수 검증)
    private Integer teacherCode; // 학생이 입력할 선생님의 초대 코드 (UUID 문자열)

    // 기타 프로필 정보 (선생님/학생 모두에게 선택적 또는 업데이트 시 사용)
    private Integer grade;
    private Integer classroom;

    public UserEntity toEntity() {
        return UserEntity.builder()
                .name(this.name)
                .password(this.password)
                .nickname(this.nickname)
                .role(this.role)
                .teacherCode(this.teacherCode)
                .grade(this.grade)
                .classroom(this.classroom)
                .build();
    }
}
